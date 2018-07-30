Ansible Scripts Using Hammer Cli To Populate Entities In Foreman
==============================================

Using ansible roles to manage and populate different entities in the foreman itself with the help of hammer cli tool.

Under ansible_hammercli_scripts,You will find ansible playbooks written specially for populating various entities such as architecture,operating systems,hosts in the foreman instance.

.. note:: For Ansible Installation Refer to Ansible Documentation to know more about it ---- https://docs.ansible.com/ansible/devel/user_guide/intro_getting_started.html

These playbooks are run with extra variables/parameters that must be passed along with ansible-playbook command using -e option for each parameter.
For example:
 To run the creating_user_input.yml , you can use 
             ansible-playbook creating_user_input.yml -e "variable_host=foreman.varadsp.com" -e "username=aaaa" -e "user=admin" -e "pass=redhat"
   
  In this variable host is the name of the host machine on which foreman is installed and hammer cli is configured,You can use ip of the machine too.
user parameter is the username for admin and pass parameter is password for admin access to foreman instance.

