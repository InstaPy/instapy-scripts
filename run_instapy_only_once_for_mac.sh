#!/bin/bash

# This is a script to mitigate possibility of multiple parallel cron jobs being triggered(discussed here: https://github.com/timgrossmann/InstaPy/issues/1235)
# The following is an example of a cron scheduled every 10 mins
# */10 * * * * bash /path/to/instapy-scripts/run_instapy_only_once_for_mac.sh /path/to/instapy/quickstart_templates/target_followers_of_similar_accounts_and_influencers.py

TEMPLATE_PATH=$1
USERNAME=$2
PASSWORD=$3
if [ -z "$3" ]
then
   echo "Error: Missing arguments"
   echo "Usage: bash $0 <script-path> <username> <password>"
   exit 1
fi

if ps aux | grep $TEMPLATE_PATH | awk '{ print $11 }' | grep python
then
   echo "$TEMPLATE_PATH is already running"
else
   echo "Starting $TEMPLATE_PATH"
   python $TEMPLATE_PATH -u $USERNAME -p $PASSWORD --headless-browser --disable_image_load
fi

