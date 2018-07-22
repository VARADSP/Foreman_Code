import subprocess
import sys
import os

user1 = raw_input("Enter admin username for foreman\n")
pass1 = raw_input("Enter admin password for " + user1+"\n")
host = raw_input("Enter hostname or ip of foreman machinen\n")
username1 = raw_input("Enter username of user to be created\n")
password1 = raw_input("Enter password for "+username1+ '\n')
mailid1 = raw_input("Enter mail id for "+username1+' \n')


result = os.system('ansible-playbook scripts/creating_user_input.yml -e "variable_host='+host+'" -e "username='+username1+' -e password='+password1+' -e mailid='+mailid1+' " -e "user='+user1+'" -e "pass='+pass1+'"')




#command = 'ansible-playbook scripts/creating_user_input.yml -e \"variable_host=foreman.varadsp.com\" -e \"username=aaa11\" -e \"user=admin\" -e \"pass=redhat\"'
#print command.split()
#subprocess.check_call(command.split())

#result = subprocess.check_output(['ansible-playbook'],['scripts/creating_user_input.yml'],['-e'],['\"variable_host='+host+'\"'],['-e'],['\"username='+username1+'\"'],['-e'],['\"user='+user1+'\"'],['-e'],['\"pass='+pass1+'\"'])
if result==0:
 sys.stderr.write('Successfully created user in '+host+' \n')
else:
 sys.stderr.write('Error occured '+result+' \n')
