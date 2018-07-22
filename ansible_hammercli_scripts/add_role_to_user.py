import subprocess
import sys
import os

user1 = raw_input("Enter admin username for foreman\n")
pass1 = raw_input("Enter admin password for " + user1+"\n")
host = raw_input("Enter hostname or ip of foreman machinen\n")



result1 = os.system('ansible-playbook scripts/list_users.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result1==0:
 sys.stderr.write('User listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')


result2 = os.system('ansible-playbook scripts/list_roles.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+'"')

if result2==0:
 sys.stderr.write('Roles listed successfully\n')
else:
 sys.stderr.write('Error Occurred \n')

username1 = raw_input("Enter username for assigning role \n")
rolename1 = raw_input("Enter rolename to be assigned to "+username1+ '\n')


result = os.system('ansible-playbook scripts/add_role_to_user.yml -e "variable_host='+host+' -e "user='+user1+' -e "pass='+pass1+' -e "username='+username1+' -e "rolename='+rolename1+'"')


#result = os.system('ansible-playbook scripts/creating_user_input.yml -e "variable_host='+host+'" -e "username='+username1+' -e password='+password1+' -e mailid='+mailid1+' " -e "user='+user1+'" -e "pass='+pass1+'"')




#command = 'ansible-playbook scripts/creating_user_input.yml -e \"variable_host=foreman.varadsp.com\" -e \"username=aaa11\" -e \"user=admin\" -e \"pass=redhat\"'
#print command.split()
#subprocess.check_call(command.split())

#result = subprocess.check_output(['ansible-playbook'],['scripts/creating_user_input.yml'],['-e'],['\"variable_host='+host+'\"'],['-e'],['\"username='+username1+'\"'],['-e'],['\"user='+user1+'\"'],['-e'],['\"pass='+pass1+'\"'])
if result==0:
 sys.stderr.write('Successfully assigned '+rolename1+ ' to ' +username1+ '\n')
else:
 sys.stderr.write('Error occurred '+ result + '\n')

