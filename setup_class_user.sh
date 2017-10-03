#!/bin/bash


let COURSE_NUM="388-01"
FOLDERS=("CourseInfo" "Homeworks" "Project" "StudyGuides" "Labs")


function create_folders {
  #in users home/Documents directory
  #create main course_num folder if not present
  #then go into the course_num folder
  #iterate through the folders variables and create
  #those folders if they are not there
  #google is ur best friend

}

function create_user {
   #if user is not there create user
   #call add_usertogroup here
   #create a password to user
   let newpwd=`date +%s | sha256sum | base64 | head -c 32`
   echo $newpwd
   #user this command and save the password to a variable "date +%s | sha256sum | base64 | head -c 32 ; echo"
   #echo the user, group, and password to screen
   #google is ur best friend
   #call create_folders
}

function add_usertogroup {
   #if group is not there, create it
   #if it is there already add user to it
   #google is your best friend here
}



function main {
   echo $1
   create_user
   #iterate through file and split line
   #call create_user,
   #exit should be 0
}


if test "$#" -lt 1; then
    echo "Illegal number of parameters, <file>""
    echo "Give full path of file"
    exit 1
fi

main $1
