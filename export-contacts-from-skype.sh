#!/usr/bin/env bash

script_name=`basename $0`
skype_name=$1
sqlite_location="/usr/bin/"

source shell-utils.sh

print_header "Exporting Skype contacts"

display_usage () {
  print_message "Skype name not specified..."
  indicator_amber
  print_message "Usage: ./$script_name <skypename>" "\n"
  exit 1
}

check_skype_database () {
  print_message_with_param "Checking SQLite database..." "main.db"
  if [ -f "$HOME/Library/Application Support/Skype/$skype_name/main.db" ]; then
    indicator_green
  else
    indicator_red
    print_message "Skype database cannot be found..." "\n"
    exit 1
  fi
}

extract_data () {
  print_message_with_param "Extracting data from database..." $skype_name
  $sqlite_location/sqlite3 -batch "$HOME/Library/Application Support/Skype/$skype_name/main.db" <<EOF
.mode csv
.output contacts.csv
select skypename, fullname, languages, country, city, phone_office, phone_mobile, displayname, given_displayname, phone_mobile_normalized from Contacts;
.output stdout
.exit
EOF
  indicator_green
}

rename_file () {
  print_message_with_param "Renaming file..." contacts-$skype_name.csv
  if [ -f "contacts.csv" ]; then
    mv contacts.csv contacts-$skype_name.csv
    indicator_green
  else
    indicator_red
    print_message "contacts.csv cannot be found..." "\n"
    exit 1
  fi
}

if [ "$#" -eq 0 ]; then
  display_usage
else
  check_skype_database
  extract_data
  rename_file
fi

exit 0
