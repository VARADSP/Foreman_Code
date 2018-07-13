class PermissionsList
  class << self
    def permissions
      [
        ['Architecture', 'view_architectures'],
        ['Architecture', 'create_architectures'],
        ['Architecture', 'edit_architectures'],
        ['Architecture', 'destroy_architectures'],
        ['Audit', 'view_audit_logs'],
        ['AuthSourceLdap', 'view_authenticators'],
        ['AuthSourceLdap', 'create_authenticators'],
        ['AuthSourceLdap', 'edit_authenticators'],
        ['AuthSourceLdap', 'destroy_authenticators'],
        ['Bookmark', 'view_bookmarks'],
        ['Bookmark', 'create_bookmarks'],
        ['Bookmark', 'edit_bookmarks'],
        ['Bookmark', 'destroy_bookmarks'],
        ['ComputeProfile', 'view_compute_profiles'],
        ['ComputeProfile', 'create_compute_profiles'],
        ['ComputeProfile', 'edit_compute_profiles'],
        ['ComputeProfile', 'destroy_compute_profiles'],
        ['ComputeResource', 'view_compute_resources'],
        ['ComputeResource', 'create_compute_resources'],
        ['ComputeResource', 'edit_compute_resources'],
        ['ComputeResource', 'destroy_compute_resources'],
        ['ComputeResource', 'view_compute_resources_vms'],
        ['ComputeResource', 'create_compute_resources_vms'],
        ['ComputeResource', 'edit_compute_resources_vms'],
        ['ComputeResource', 'destroy_compute_resources_vms'],
        ['ComputeResource', 'power_compute_resources_vms'],
        ['ComputeResource', 'console_compute_resources_vms'],
        ['ConfigReport', 'view_config_reports'],
        ['ConfigReport', 'destroy_config_reports'],
        ['ConfigReport', 'upload_config_reports'],
        ['ConfigGroup', 'view_config_groups'],
        ['ConfigGroup', 'create_config_groups'],
        ['ConfigGroup', 'edit_config_groups'],
        ['ConfigGroup', 'destroy_config_groups'],
        [nil, 'access_dashboard'],
        ['Domain', 'view_domains'],
        ['Domain', 'create_domains'],
        ['Domain', 'edit_domains'],
        ['Domain', 'destroy_domains'],
        ['Environment', 'view_environments'],
        ['Environment', 'create_environments'],
        ['Environment', 'edit_environments'],
        ['Environment', 'destroy_environments'],
        ['Environment', 'import_environments'],
        ['ExternalUsergroup', 'view_external_usergroups'],
        ['ExternalUsergroup', 'create_external_usergroups'],
        ['ExternalUsergroup', 'edit_external_usergroups'],
        ['ExternalUsergroup', 'destroy_external_usergroups'],
        ['FactValue', 'view_facts'],
        ['FactValue', 'upload_facts'],
        ['Filter', 'view_filters'],
        ['Filter', 'create_filters'],
        ['Filter', 'edit_filters'],
        ['Filter', 'destroy_filters'],
        ['HostClass', 'edit_classes'],
        ['Hostgroup', 'view_hostgroups'],
        ['Hostgroup', 'create_hostgroups'],
        ['Hostgroup', 'edit_hostgroups'],
        ['Hostgroup', 'destroy_hostgroups'],
        ['Host', 'view_hosts'],
        ['Host', 'create_hosts'],
        ['Host', 'edit_hosts'],
        ['Host', 'destroy_hosts'],
        ['Host', 'build_hosts'],
        ['Host', 'power_hosts'],
        ['Host', 'console_hosts'],
        ['Host', 'ipmi_boot_hosts'],
        ['Host', 'puppetrun_hosts'],
        ['Image', 'view_images'],
        ['Image', 'create_images'],
        ['Image', 'edit_images'],
        ['Image', 'destroy_images'],
        ['KeyPair', 'view_keypairs'],
        ['KeyPair', 'destroy_keypairs'],
        ['Location', 'view_locations'],
        ['Location', 'create_locations'],
        ['Location', 'edit_locations'],
        ['Location', 'destroy_locations'],
        ['Location', 'assign_locations'],
        ['VariableLookupKey', 'view_external_variables'],
        ['VariableLookupKey', 'create_external_variables'],
        ['VariableLookupKey', 'edit_external_variables'],
        ['VariableLookupKey', 'destroy_external_variables'],
        ['PuppetclassLookupKey', 'view_external_parameters'],
        ['PuppetclassLookupKey', 'create_external_parameters'],
        ['PuppetclassLookupKey', 'edit_external_parameters'],
        ['PuppetclassLookupKey', 'destroy_external_parameters'],
        ['MailNotification', 'view_mail_notifications'],
        ['Medium', 'view_media'],
        ['Medium', 'create_media'],
        ['Medium', 'edit_media'],
        ['Medium', 'destroy_media'],
        ['Model', 'view_models'],
        ['Model', 'create_models'],
        ['Model', 'edit_models'],
        ['Model', 'destroy_models'],
        ['Operatingsystem', 'view_operatingsystems'],
        ['Operatingsystem', 'create_operatingsystems'],
        ['Operatingsystem', 'edit_operatingsystems'],
        ['Operatingsystem', 'destroy_operatingsystems'],
        ['Organization', 'view_organizations'],
        ['Organization', 'create_organizations'],
        ['Organization', 'edit_organizations'],
        ['Organization', 'destroy_organizations'],
        ['Organization', 'assign_organizations'],
        ['Parameter', 'view_params'],
        ['Parameter', 'create_params'],
        ['Parameter', 'edit_params'],
        ['Parameter', 'destroy_params'],
        ['Ptable', 'view_ptables'],
        ['Ptable', 'create_ptables'],
        ['Ptable', 'edit_ptables'],
        ['Ptable', 'destroy_ptables'],
        ['Ptable', 'lock_ptables'],
        ['ProvisioningTemplate', 'view_provisioning_templates'],
        ['ProvisioningTemplate', 'create_provisioning_templates'],
        ['ProvisioningTemplate', 'edit_provisioning_templates'],
        ['ProvisioningTemplate', 'destroy_provisioning_templates'],
        ['ProvisioningTemplate', 'deploy_provisioning_templates'],
        ['ProvisioningTemplate', 'lock_provisioning_templates'],
        [nil, 'view_plugins'],
        ['Puppetclass', 'view_puppetclasses'],
        ['Puppetclass', 'create_puppetclasses'],
        ['Puppetclass', 'edit_puppetclasses'],
        ['Puppetclass', 'destroy_puppetclasses'],
        ['Puppetclass', 'import_puppetclasses'],
        ['Realm', 'view_realms'],
        ['Realm', 'create_realms'],
        ['Realm', 'edit_realms'],
        ['Realm', 'destroy_realms'],
        ['Role', 'view_roles'],
        ['Role', 'create_roles'],
        ['Role', 'edit_roles'],
        ['Role', 'destroy_roles'],
        ['SmartProxy', 'view_smart_proxies'],
        ['SmartProxy', 'create_smart_proxies'],
        ['SmartProxy', 'edit_smart_proxies'],
        ['SmartProxy', 'destroy_smart_proxies'],
        ['SmartProxy', 'view_smart_proxies_autosign'],
        ['SmartProxy', 'create_smart_proxies_autosign'],
        ['SmartProxy', 'destroy_smart_proxies_autosign'],
        ['SmartProxy', 'view_smart_proxies_puppetca'],
        ['SmartProxy', 'edit_smart_proxies_puppetca'],
        ['SmartProxy', 'destroy_smart_proxies_puppetca'],
        ['SshKey', 'view_ssh_keys'],
        ['SshKey', 'create_ssh_keys'],
        ['SshKey', 'destroy_ssh_keys'],
        [nil, 'view_statistics'],
        ['Subnet', 'view_subnets'],
        ['Subnet', 'create_subnets'],
        ['Subnet', 'edit_subnets'],
        ['Subnet', 'destroy_subnets'],
        ['Subnet', 'import_subnets'],
        [nil, 'view_tasks'],
        ['Trend', 'view_trends'],
        ['Trend', 'create_trends'],
        ['Trend', 'edit_trends'],
        ['Trend', 'destroy_trends'],
        ['Trend', 'update_trends'],
        ['Usergroup', 'view_usergroups'],
        ['Usergroup', 'create_usergroups'],
        ['Usergroup', 'edit_usergroups'],
        ['Usergroup', 'destroy_usergroups'],
        ['User', 'view_users'],
        ['User', 'create_users'],
        ['User', 'edit_users'],
        ['User', 'destroy_users']
      ]
    end
  end
end
