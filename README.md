
This script - based on your `Skype name` - extracts data from Skype's local SQLite database into a CSV file.

Please feel free to exclude columns you don't need by editing the `select statement` in following section:

``` shell
.mode csv
.output contacts.csv
select skypename, fullname, languages, country, city, phone_office, phone_mobile, displayname, given_displayname, phone_mobile_normalized from Contacts;
.output stdout
.exit
```

***NOTE:*** the path of the main.db is specific to default Mac OS location, modifying it may make the script work on Linux systems as well.

#### Tested on

* Mac OS X Yosemite 10.10.2 with Skype 7.2
