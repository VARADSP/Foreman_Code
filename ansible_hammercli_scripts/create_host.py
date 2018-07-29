import subprocess
import sys
import os

user1 = raw_input("Enter admin username for foreman\n")
pass1 = raw_input("Enter admin password for " + user1+"\n")
host = raw_input("Enter hostname or ip of foreman machinen\n")



result1 = os.system('ansible-playbook scripts/list_architectures.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('Architectures listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')

result1 = os.system('ansible-playbook scripts/list_os.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('Operating systems listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')



result1 = os.system('ansible-playbook scripts/list_domain.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('Domains listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')


result1 = os.system('ansible-playbook scripts/list_medium.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('Mediums listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')

result1 = os.system('ansible-playbook scripts/list_environment.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('Environments listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')


result1 = os.system('ansible-playbook scripts/list_partition-table.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('Partition tables listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')


result1 = os.system('ansible-playbook scripts/list_puppet-proxy.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('Puppet proxies listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')


name = raw_input("Enter Name for the host  \n")
architectureid = raw_input("Enter architecture id for creating host \n")
osid = raw_input("Enter operating system id for host \n")
domainid = raw_input("Enter domain id for host \n")
mediumid = raw_input("Enter medium id for host \n")

environmentid = raw_input("Enter environment id for host \n")
puppetproxyid = raw_input("Enter puppet proxy id for host \n")
partitiontableid = raw_input("Enter partition-table id for host \n")

macaddr = raw_input("Enter mac address for host \n")
ipaddr = raw_input("Enter ip address for host \n")

rootpass = raw_input("Enter root password for host \n")

result = os.system('ansible-playbook scripts/create_host.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+' -e "name='+name+' -e "mac_addr='+macaddr+' -e "ip_addr='+ipaddr+' -e "architecture_id='+architectureid+' -e "os_id='+osid+' -e "domain_id='+domainid+' -e partitiontable_id='+partitiontableid+' -e "puppetproxy_id='+puppetproxyid+' -e "environment_id='+environmentid+' -e medium_id='+mediumid+' -e root_pass='+rootpass+'"')



#result = os.system('ansible-playbook scripts/creating_user_input.yml -e "variable_host='+host+'" -e "username='+username1+' -e password='+password1+' -e mailid='+mailid1+' " -e "user='+user1+'" -e "pass='+pass1+'"')




#command = 'ansible-playbook scripts/creating_user_input.yml -e \"variable_host=foreman.varadsp.com\" -e \"username=aaa11\" -e \"user=admin\" -e \"pass=redhat\"'
#print command.split()
#subprocess.check_call(command.split())

#result = subprocess.check_output(['ansible-playbook'],['scripts/creating_user_input.yml'],['-e'],['\"variable_host='+host+'\"'],['-e'],['\"username='+username1+'\"'],['-e'],['\"user='+user1+'\"'],['-e'],['\"pass='+pass1+'\"'])
if result==0:
 sys.stderr.write('Successfully created host '+name+ ' with mac address ' +macaddr+ ' with ip address '+ipaddr+'\n')
else:
 sys.stderr.write('Error occurred '+ result + '\n')

