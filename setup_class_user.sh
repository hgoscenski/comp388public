#!/bin/bash


COURSE_NUM="388-01"
FOLDERS=("CourseInfo" "Homeworks" "Project" "StudyGuides" "Labs")


function create_folders {
	local USER=$1
	local DIR="/home/$USER/Documents/$COURSE_NUM"
	if [ ! -d "$DIR" ]; then
		echo "		Making $DIR"
		mkdir -p "$DIR/" &> /dev/null
	fi
	for i in "${FOLDERS[@]}"
	do
		echo "		Checking for $DIR/$i"
		if [ ! -d "$DIR/$i" ]; then 
			mkdir "$DIR/$i/" &>/dev/null
			echo "		Making $i directory"
		else
			echo "		Exists!"
		fi
	done
  #in users home/Documents directory
  #create main course_num folder if not present
  #then go into the course_num folder
  #iterate through the folders variables and create
  #those folders if they are not there
  #google is ur best friend
}

function create_user {
	local USERNAME="$1"
	local NAME="$2"
	local GROUP="$3"
	local newpwd=`date +%s%3N | sha256sum | base64 | head -c 32`
#	date +%s%3N
#	Modified the password generation script to use nanaoseconds in addition to the seconds
#	The computer I was testing the script on was too fast- it was giving several of the accounts
#	The same password due to the epoch time being the same with only seconds.
#	echo $newpwd
	if [ ! -z "$(getent passwd $USERNAME)" ]; then
		echo "User exists, checking group and folder."
		create_folders $USERNAME
		add_usertogroup $USERNAME $GROUP
	else
		echo "User $USERNAME does not exist. Adding user"
		useradd $USERNAME &> /dev/null
		echo "Adding user to group: $GROUP"
		add_usertogroup $USERNAME $GROUP &> /dev/null
		echo "Setting user password"
		echo "$USERNAME:$newpwd" | chpasswd &> /dev/null
		echo "Creating required user folders"
		create_folders $USERNAME
	fi	
	echo "User- $USERNAME with password: $newpwd and group: $GROUP"
	echo "-----------------------------------------------------------------------------"
	echo ""
   #if user is not there create user
   #call add_usertogroup here
   #create a password to user
#   let newpwd=`date +%s | sha256sum | base64 | head -c 32`
#   echo $newpwd
   #user this command and save the password to a variable "date +%s | sha256sum | base64 | head -c 32 ; echo"
   #echo the user, group, and password to screen
   #google is ur best friend
   #call create_folders
}

function add_usertogroup {
	local USERNAME=$1
	local GROUP=$2
	groupadd -f $GROUP &> /dev/null
	usermod -G -a $GROUP $USERNAME &> /dev/null
   #if group is not there, create it
   #if it is there already add user to it
   #google is your best friend here
}



function main {
   	echo "Using $1"
	if [ `echo $1 | grep .csv` ]; then
		cat $1 | while read line
		do
			USERARRAY=(`echo $line | sed 's/,/\n/g'`)		
			create_user ${USERARRAY[2]} "${USERARRAY[1]}" ${USERARRAY[3]}
		done
	else
		echo "That is not a  csv"
		exit 1
	fi
	exit 0
   #iterate through file and split line
   #call create_user,
   #exit should be 0
}


if test "$#" -lt 1; then
    echo "Illegal number of parameters, <file>"
    echo "Give full path of file"
    exit 1
fi

main $1
