# Methods added to this helper will be available to all templates in the application
module ApplicationHelper
  include HomeHelper

  # Add autogenerated html data-id attribute if not present (prefixed with "aid_")
  def link_to(*args, &block)
    if block_given?
      super(*args)
    else
      options = args[1] || {}
      html_options = args[2] || {}
      unless html_options.has_key?(:'data-id') || (options.is_a?(String) && options.starts_with?("mailto:"))
        begin
          path = URI.split(url_for(options) || html_options['href'])[5].split(/\//).select {|x| !x.empty?}
          if path.size > 0
            max = path.size <= 3 ? path.size : 3
            id = path.last(max).join('_')
          else
            id = 'not_defined'
          end
        rescue => e
          Foreman::Logging.exception("Failed generating link using #{args.inspect}", e)
          id = 'not_parseable'
        end
        html_options.merge!(:'data-id' => "aid_#{id}")
      end
      if html_options[:confirm]
        html_options[:data] ||= {}
        html_options[:data][:confirm] = html_options.delete(:confirm)
      end
      super(args[0], args[1], html_options)
    end
  end

  def link_to_function(name, function, html_options = {})
    onclick_tag = "#{html_options[:onclick]}; " if html_options[:onclick]
    onclick = "#{onclick_tag}#{function}; return false;"
    href = html_options[:href] || '#'

    content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
  end

  # the same method is defined in hosts but we need to have this available in all views
  # because of plugins that are extending bulk actions menu, their actions don't use hosts controller
  def multiple_with_filter?
    params.key?(:search)
  end

  protected

  def contract(model)
    model.to_label
  end

  def show_habtm(associations)
    render :partial => 'common/show_habtm', :collection => associations, :as => :association
  end

  def link_to_remove_puppetclass(klass, type)
    options = options_for_puppetclass_selection(klass, type)
    text = remove_link_to_function(truncate(klass.name, :length => 28), options)
    content_tag(:span, text).html_safe +
        remove_link_to_function('', options.merge(:class => 'glyphicon glyphicon-minus-sign'))
  end

  def remove_link_to_function(text, options)
    options.delete_if { |key, value| !options[key].to_s } # otherwise error during template render
    title = (_("Click to remove %s") % options[:"data-class-name"])
    link_to_function(text, "remove_puppet_class(this)", options.merge!(:'data-original-title'=> title))
  end

  def link_to_add_puppetclass(klass, type)
    options = options_for_puppetclass_selection(klass, type)
    text = add_link_to_function(truncate(klass.name, :length => 28), options)
    content_tag(:span, text).html_safe +
        add_link_to_function('', options.merge(:class => 'glyphicon glyphicon-plus-sign'))
  end

  def add_link_to_function(text, options)
    link_to_function(text, "add_puppet_class(this)",
        options.merge(:'data-original-title' => _("Click to add %s") % options[:"data-class-name"]))
  end

  # Return true if user is authorized for controller/action, otherwise false
  # +options+ : Hash containing
  #             :controller : String or symbol for the controller, defaults to params[:controller]
  #             :action     : String or symbol for the action
  #             :id         : Id parameter
  #             :auth_action: String or symbol for the action, this has higher priority that :action
  #             :auth_object: Specific object on which we may verify particular permission
  #             :authorizer : Specific authorizer to perform authorization on (handy to inject authorizer with base collection)
  #             :permission : Specific permission to check authorization on (handy on custom permission names)
  def authorized_for(options)
    action          = options.delete(:auth_action) || options[:action]
    object          = options.delete(:auth_object)
    user            = User.current
    controller      = options[:controller] || params[:controller]
    controller_name = controller.to_s.gsub(/::/, "_").underscore
    id              = options[:id]
    user_id         = options[:user_id].to_param
    permission      = options.delete(:permission) || [action, controller_name].join('_')

    if object.nil?
      user.allowed_to?({ :controller => controller_name, :action => action, :id => id, :user_id => user_id }) rescue false
    else
      authorizer = options.delete(:authorizer) || Authorizer.new(user)
      authorizer.can?(permission, object) rescue false
    end
  end

  # Display a link if user is authorized, otherwise a string
  # +name+    : String to be displayed
  # +options+ : Hash containing options for authorized_for and link_to
  # +html_options+ : Hash containing html options for the link or span
  def link_to_if_authorized(name, options = {}, html_options = {})
    enable_link = authorized_for(options)
    if enable_link
      link_to name, options, html_options
    else
      link_to_function name, nil, html_options.merge!(:class => "#{html_options[:class]} disabled", :disabled => true)
    end
  end

  # Display a link to JS function if user is authorized, otherwise a string
  # +name+    : String to be displayed
  # +options+ : Hash containing options for authorized_for and link_to
  # +html_options+ : Hash containing html options for the link or span
  def link_to_function_if_authorized(name, function, options = {}, html_options = {})
    if authorized_for(options)
      link_to_function name, function, html_options
    else
      link_to_function name, nil, html_options.merge!(:class => "#{html_options[:class]} disabled", :disabled => true)
    end
  end

  def display_delete_if_authorized(options = {}, html_options = {})
    text = options.delete(:text) || _("Delete")
    method = options.delete(:method) || :delete
    options = {:auth_action => :destroy}.merge(options)
    html_options = { :data => { :confirm => _('Are you sure?') }, :method => method }.merge(html_options)
    display_link_if_authorized(text, options, html_options)
  end

  # Display a link if user is authorized, otherwise nothing
  # +name+    : String to be displayed
  # +options+ : Hash containing options for authorized_for and link_to
  # +html_options+ : Hash containing html options for the link or span
  def display_link_if_authorized(name, options = {}, html_options = {})
    if authorized_for(options)
      link_to(name, options, html_options)
    else
      ""
    end
  end

  def new_link(name, options = {}, html_options = {})
    options[:action] = :new
    html_options[:class] = "btn btn-primary #{html_options[:class]}"
    display_link_if_authorized(name, options, html_options)
  end

  def csv_link(permitted: [])
    link_to(_('Export'), current_url_params(:permitted => permitted).merge(:format => :csv),
      {:title => _('Export to CSV'), :class => 'btn btn-default', 'data-no-turbolink' => true})
  end

  # renders a style=display based on an attribute properties
  def display?(attribute = true)
    "style=#{display(attribute)}"
  end

  def display(attribute)
    "display:#{attribute ? 'none' : 'inline'};"
  end

  # return our current model instance type based on the current controller
  # i.e. HostsController would return "host"
  def type
    controller_name.singularize
  end

  def checked_icon(condition)
    icon_text('check', '', :kind => 'fa') if condition
  end

  def locked_icon(condition, hovertext)
    ('<span class="glyphicon glyphicon-lock" title="%s"/>' % hovertext).html_safe if condition
  end

  def searchable?
    return false if (SETTINGS[:login] && !User.current) || @welcome || @missing_permissions
    if (controller.action_name == "index") || (defined?(SEARCHABLE_ACTIONS) && (SEARCHABLE_ACTIONS.include?(controller.action_name)))
      controller.respond_to?(:auto_complete_search)
    end
  end

  def auto_complete_controller_name
    controller.respond_to?(:auto_complete_controller_name) ? controller.auto_complete_controller_name : controller_name
  end

  def auto_complete_search(name, val, options = {})
    path = options[:full_path]
    path ||= (options[:path] || send("#{auto_complete_controller_name}_path")) + "/auto_complete_#{name}"
    options.merge!(:class => "autocomplete-input form-control", :'data-url' => path)
    text_field_tag(name, val, options)
  end

  def sort(field, permitted: [], **kwargs)
    kwargs[:url_options] ||= current_url_params(permitted: permitted)
    super(field, kwargs)
  end

  def help_button
    link_to(_("Help"), { :action => "welcome" }, { :class => 'btn btn-default' }) if File.exist?("#{Rails.root}/app/views/#{controller_name}/welcome.html.erb")
  end

  def method_path(method)
    controller = controller_name.start_with?('compute') ? 'hosts' : controller_name
    send("#{method}_#{controller}_path")
  end

  def edit_textfield(object, property, options = {})
    edit_inline(object, property, options)
  end

  def edit_textarea(object, property, options = {})
    edit_inline(object, property, options.merge({:type => "textarea"}))
  end

  def edit_select(object, property, options = {})
    edit_inline(object, property, options.merge({:type => "select"}))
  end

  def flot_pie_chart(name, title, data, options = {})
    data = data.map { |k,v| {:label=>k.to_s.humanize, :data=>v} } if data.is_a?(Hash)
    data.map{|element| element[:label] = truncate(element[:label],:length => 16)}
    header = content_tag(:h4,(options[:show_title]) ? title : '', :class=>'ca pie-title', :'data-original-title'=>_("Expand the chart"), :rel=>'twipsy')
    link_to_function(header, "expand_chart(this)")+
        content_tag(:div, nil,
                    { :id    => name,
                      :class => 'statistics-pie',
                      :data  => {
                        :'title'  => title,
                        :'series' => data,
                        :'url'    => options[:search] ? "#{request.script_name}/hosts?search=#{URI.encode(options.delete(:search))}" : "#"
                      }
                    }.merge(options))
  end

  def flot_chart(name, xaxis_label, yaxis_label, data, options = {})
    data = data.map { |k,v| {:label=>k.to_s.humanize, :data=>v} } if data.is_a?(Hash)
    content_tag(:div, nil,
                { :id    => name,
                  :class => 'statistics-chart',
                  :data  => {
                    :'legend-options' => options.delete(:legend),
                    :'xaxis-label'    => xaxis_label,
                    :'yaxis-label'    => yaxis_label,
                    :'series'         => data
                  }
                }.merge(options))
  end

  def flot_bar_chart(name, xaxis_label, yaxis_label, data, options = {})
    i=0
    ticks = nil
    if data.is_a?(Array)
      data = data.map do |kv|
        ticks ||=[]
        ticks << [i+=1,kv[0].to_s.humanize ]
        [i,kv[1]]
      end
    elsif  data.is_a?(Hash)
      data = data.map do |k,v|
        ticks ||=[]
        ticks << [i+=1,k.to_s.humanize ]
        [i,v]
      end
    end

    content_tag(:div, nil,
                { :id   => name,
                  :data => {
                    :'xaxis-label' => xaxis_label,
                    :'yaxis-label' => yaxis_label,
                    :'chart'   => data,
                    :'ticks'   => ticks
                  }
                }.merge(options))
  end

  def select_action_button(title, options = {}, *args)
    # the no-buttons code is needed for users with less permissions
    args = args.flatten.select(&:present?)
    return if args.blank?

    content_tag(:div, options.merge(:class=>'btn-group')) do
      #single button
      if args.length == 1
        content_tag(:span, args[0], :class => 'btn btn-default').html_safe
      #multiple options
      else
        link_to((title + " " + content_tag(:span, '', :class => 'caret')).html_safe, '#',
              :class => "btn btn-default dropdown-toggle", :'data-toggle' => 'dropdown') +
             content_tag(:ul, :class=>"dropdown-menu pull-right") do
               args.map{ |option| content_tag(:li,option) }.join(" ").html_safe
             end
      end
    end
  end

  def action_buttons(*args)
    # the no-buttons code is needed for users with less permissions
    args = args.flatten.select(&:present?)
    return if args.blank?

    #single button
    return content_tag(:span, args[0].html_safe, :class=>'btn btn-sm btn-default') if args.length == 1

    #multiple buttons
    primary = args.delete_at(0).html_safe
    primary = content_tag(:span, primary, :class=>'btn btn-sm btn-default') if primary !~ /btn/

    content_tag(:div,:class => "btn-group") do
      primary + link_to(content_tag(:span, '', :class=>'caret'),'#', :class=>"btn btn-default #{'btn-sm' if primary =~ /btn-sm/} dropdown-toggle", :'data-toggle'=>'dropdown') +
      content_tag(:ul,:class=>"dropdown-menu pull-right") do
        args.map{|option| content_tag(:li,option)}.join(" ").html_safe
      end
    end
  end

  def avatar_image_tag(user, html_options = {})
    if user.avatar_hash.present?
      image_tag("avatars/#{user.avatar_hash}.jpg", html_options)
    elsif Setting[:use_gravatar] && user.mail.present?
      image_tag(gravatar_image(user.mail),
                html_options.merge!(gravatar_html_options))
    else
      image_tag('user.jpg', html_options)
    end
  end

  def gravatar_image(email)
    "#{request.protocol}secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?d=mm&s=30"
  end

  def gravatar_html_options
    { :onerror => "this.src='#{path_to_image('user.jpg')}'",
      :alt     => _('Change your avatar at gravatar.com') }
  end

  def readonly_field(object, property, options = {})
    name       = "#{type}[#{property}]"
    helper     = options[:helper]
    value      = helper.nil? ? object.send(property) : self.send(helper, object)
    klass      = options[:type]
    title      = options[:title]

    opts = { :title => title, :class => klass.to_s, :name => name, :value => value}

    content_tag_for :span, object, opts do
      h(value)
    end
  end

  def obj_type(obj)
    obj.class.model_name.to_s.tableize.singularize
  end

  def class_in_environment?(environment,puppetclass)
    return false unless environment
    environment.puppetclasses.map(&:id).include?(puppetclass.id)
  end

  def show_parent?(obj)
    minimum_count = obj.new_record? ? 0 : 1
    base = obj.class.respond_to?(:completer_scope) ? obj.class.completer_scope(nil) : obj.class
    base.count > minimum_count
  end

  def documentation_button(section = "", options = {})
    url = documentation_url section, options
    link_to(icon_text('help', _('Documentation'), :kind => 'pficon'),
      url, :rel => 'external', :class => 'btn btn-default btn-docs', :target => '_blank')
  end

  def generate_links_for(sub_model)
    return _("None found") if sub_model.to_a.empty?
    sub_model.map {|model| link_to(model.to_label, { :controller => model.class.model_name.plural.downcase, :action => :index, :search => "name = \"#{model.name}\"" })}.to_sentence
  end

  def cancel_path_with_index_search
    prev_controller_url = session["redirect_to_url_#{controller_name}"].to_s
    return nil unless prev_controller_url.include?('search')
    prev_controller_url
  end

  # creates a data set for editable select-optgroup. each element in the 'groups' array is a hash represents a group with its children.
  # e.g - {:name => _("Users"), :class => 'user', :scope => 'visible', :value_method => 'id_and_type', :text_method => 'login'}
  # :name -> group's name, :scope -> scoped method (e.g 'all' or another predefined scope),
  # :value_method -> value in params, and text_method -> the shown text in the select element.

  def editable_select_optgroup(groups, options = {})
    select = []
    select.push(nil => options[:include_blank]) if options[:include_blank].present?
    groups.each do |group|
      klass = group[:class].classify.constantize
      scope = group[:scope]
      children = Hash[klass.send(scope).map {|obj| [obj.send(group[:value_method]), obj.send(group[:text_method])]}]
      select.push(:text => group[:name], :children => children)
    end
    select
  end

  private

  def edit_inline(object, property, options = {})
    helper     = options[:helper]
    value      = helper.nil? ? object.send(property) : self.send(helper, object)
    klass      = options[:class]
    update_url = options[:update_url] || url_for(object)
    type       = options[:type]
    title      = options[:title]

    editable(object, property, {:type => type, :title => title, :value => value, :class => klass, :source => options[:select_values],:url => update_url}.compact)
  end

  def documentation_url(section = "", options = {})
    root_url = options[:root_url] || "http://www.theforeman.org/manuals/#{SETTINGS[:version].short}/index.html#"
    if section.empty?
      "http://www.theforeman.org/documentation.html##{SETTINGS[:version].short}"
    else
      root_url + section
    end
  end

  def options_for_puppetclass_selection(klass, type)
    {
      :'data-class-id'   => klass.id,
      :'data-class-name' => klass.name,
      :'data-type'       => type,
      :'data-url'        => parameters_puppetclass_path(:id => klass.id),
      :rel               => 'twipsy'
    }
  end

  def spinner(text = '', options = {})
    if text.present?
      "<p class='spinner-label'> #{text} </p><div id='#{options[:id]}' class='spinner spinner-xs spinner-inline #{options[:class]}'>
      </div>".html_safe
    else
      "<div id='#{options[:id]}' class='spinner spinner-xs #{options[:class]}'></div>".html_safe
    end
  end

  def hidden_spinner(text = '', options = {})
    if options[:class]
      options[:class] += " hide"
    else
      options[:class] = "hide"
    end
    spinner(text, options)
  end

  def hosts_count(resource_name = controller.resource_name)
    # If we are on /organizations or /locations, this allows to display the
    # count for hosts not in the current organization & location.
    hosts_scope = Host::Managed.reorder('')
    if ['organization', 'location'].include? resource_name
      hosts_scope = hosts_scope.unscoped
    end
    @hosts_count ||= hosts_scope.authorized.group("#{resource_name}_id").count
  end

  def webpack_dev_server
    return unless Rails.configuration.webpack.dev_server.enabled
    javascript_include_tag "#{@dev_server}/webpack-dev-server.js"
  end

  def accessible_resource_records(resource, order = :name)
    klass = resource.to_s.classify.constantize
    klass = klass.with_taxonomy_scope_override(@location, @organization) if klass.include? Taxonomix
    klass.authorized.reorder(order)
  end

  def accessible_resource(obj, resource, order = :name, association: resource)
    list = accessible_resource_records(resource, order).to_a
    # we need to allow the current value even if it was filtered
    current = obj.public_send(association) if obj.respond_to?(association)
    list |= [current] if current.present?
    list
  end

  def accessible_related_resource(obj, relation, order: :name, where: nil)
    return [] if obj.blank?
    related = obj.public_send(relation)
    related = related.with_taxonomy_scope_override(@location, @organization) if obj.class.reflect_on_association(relation).klass.include?(Taxonomix)
    related.authorized.where(where).reorder(order)
  end

  def explicit_value?(field)
    return true if params[:action] == 'clone'
    return false unless params[:host]
    !!params[:host][field]
  end

  def user_set?(field)
    # if the host has no hostgroup
    return true unless @host && @host.hostgroup
    # when editing a host, the values are specified explicitly
    return true if params[:action] == 'edit'
    return true if params[:action] == 'clone'
    # check if the user set the field explicitly despite setting a hostgroup.
    params[:host] && params[:host][:hostgroup_id] && params[:host][field]
  end

  def current_url_params(permitted: [])
    params.permit(permitted + [:locale, :search])
  end
end