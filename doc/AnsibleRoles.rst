Ansible Roles To Populate Entities In Foreman
==============================================

Ansible Roles are created to populate various entities in the foreman.To run the ansible roles a single file runsetup.yml is used to run the roles based on user choice.A single file will be executed which will further execute the ansible scripts.

Use the runsetup.yml to select the roles which you want to run,Just uncomment a role to run it and comment the ones you don't want to run in runsetup.yml.You can pass the parameters you want in the role.

To edit the host list,just use the inventory file and define the ip or hostnames of foreman servers on which you want to run the ansible roles.

.. note:: For Ansible Installation Refer to Ansible Documentation to know more about it ---- https://docs.ansible.com/ansible/devel/user_guide/intro_getting_started.html


Structure of runsetup.yml  
---
- hosts: foreman_servers # servers mentioned in the inventory file
  roles: # user and pass are admin credentials to access foreman # comment and uncomment the roles you want 
  #- {role: create_user,user: 'admin',pass: 'redhat',username: 'username',password: 'password'}# role to create user with provided username and  password
  #- {role: add_role_to_user,user: 'admin',pass: 'redhat',username: 'username',rolename: 'Manager'}# role to create user with provided username and  password
  #- {role: create_os,user: 'admin',pass: 'redhat',architecture_id: 1,architectures: 'i386',name1: 'fedora',major: 28}# create os
  #- {role: create_architecture,user: 'admin',pass: 'redhat',name: 'example',os_id: '1'}# create architecture 
  - {role: create_host,user: 'admin',pass: 'redhat',name1: 'example',mac_addr: '00:50:56:c0:00:08',ip_addr: '192.168.11.11',root_pass:      'Redhat12345@',architecture_id: '1',os_id: '1',domain_id: '1',partitiontable_id: '1',puppetproxy_id: '1',environment_id: '1',medium_id: '1'}# create host

Structure of inventory file
 
 [foreman_servers]
 theforeman.example.com
 foreman.varadsp.com

To execute the runsetup.yml file, Run the command ansible-playbook -i inventory runsetup.yml.
This will run all roles you want to populate entities in the foreman servers along with your parameters.
 
