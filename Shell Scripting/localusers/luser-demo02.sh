#!/bin/bash

# Display the UID and user of the user executing this script
# Dispay if the user is the root user or not

# Display UID
echo "Your UID is ${UID}"

# Display the username
USER_NAME=$(id -un)
echo "My username is ${USER_NAME}"

# Display if the user is root or not
if [[ "${UID}" = 0 ]]
then
  echo "You are root"
else
  echo "You are not root"
fi

