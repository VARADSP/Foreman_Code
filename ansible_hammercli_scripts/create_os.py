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

architectureid = raw_input("Enter architecture id for creating os \n")
nameofarch = raw_input("Enter name of architecture with id "+architectureid+ '\n')
nameofos = raw_input("Enter os name to be created \n")
majorver = raw_input("Enter major version of os \n")

result = os.system('ansible-playbook scripts/create_os.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+' -e "architecture_id='+architectureid+' -e "architectures='+nameofarch+' -e "name='+nameofos+' -e "major='+majorver+'"')



#result = os.system('ansible-playbook scripts/creating_user_input.yml -e "variable_host='+host+'" -e "username='+username1+' -e password='+password1+' -e mailid='+mailid1+' " -e "user='+user1+'" -e "pass='+pass1+'"')




#command = 'ansible-playbook scripts/creating_user_input.yml -e \"variable_host=foreman.varadsp.com\" -e \"username=aaa11\" -e \"user=admin\" -e \"pass=redhat\"'
#print command.split()
#subprocess.check_call(command.split())

#result = subprocess.check_output(['ansible-playbook'],['scripts/creating_user_input.yml'],['-e'],['\"variable_host='+host+'\"'],['-e'],['\"username='+username1+'\"'],['-e'],['\"user='+user1+'\"'],['-e'],['\"pass='+pass1+'\"'])
if result==0:
 sys.stderr.write('Successfully created os '+nameofos+ ' version ' +majorver+ '\n')
else:
 sys.stderr.write('Error occurred '+ result + '\n')

