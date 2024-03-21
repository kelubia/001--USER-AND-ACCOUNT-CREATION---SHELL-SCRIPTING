#!/bin/bash
#
#CREATING LOCAL USERS AND ACCOUNTS #001
#This script creates the a new local user on the system.
#You will be prompted to enter the username (login), the person name, and a password.
#The username, password, and host for the account will be displayed.

#Make sure the script is being executed with superuser privilages.
if [[ "${UID}" -ne 0 ]]
then
  echo 'please run with sudo or as root.'
  exit 1
fi

#Get the username (login)
read -p 'Enter the username to create: ' USERNAME

#Get the real name (contents for the description field).
read -p 'Enter first and last name of the account user: ' COMMENT

#Get the password.
read -p 'Enter password to be used for the account: ' PASSWORD

#Create the account.
useradd -c "${COMMENT}" -m ${USERNAME}

#Check to see if the useradd command succeeded.
#In order to relay proper staus of account creation and prevent false positives.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created. '
  exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USERNAME}

if [[ "${?}" -ne 0 ]]
then 
  echo 'The password for the account could not be set.'
  exit 1
fi

#force password change on first login.
passwd -e ${USERNAME}

#Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo  "${USERNAME}"
echo 
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0
