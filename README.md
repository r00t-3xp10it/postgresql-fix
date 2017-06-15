[![Version](https://img.shields.io/badge/postgresql_fix-1.4-brightgreen.svg?maxAge=259200)]()
[![Stage](https://img.shields.io/badge/Release-Stable-brightgreen.svg)]()
[![Build](https://img.shields.io/badge/Supported_OS-kali,Ubuntu-blue.svg)]()


![postgresql-fix v1.4](http://1.1m.yt/CqtQI1e.png)


## Postgresql-fix v1.4 - msfdb connection bugfix
    Version release: v1.4 (Stable)
    Author: pedro ubuntu [ r00t-3xp10it ]
    CodeName: Metasploit_postgresql_database_connection_fix
    Distros Supported : Linux Ubuntu, Kali, Mint, Parrot OS
    Suspicious-Shell-Activity (SSA) RedTeam develop @2017

<br /><br />

## Description:
    This tool will try to quickly fix the metasploit postgresql connection bug,
    present in postgresql.conf install versions from 9.1 to 9.7 (Incorrect port settings).
    'Just run it before using metasploit to check settings OR fix msfdb connection errors'
![postgresql-fix v1.4](http://3.1m.yt/HxhuFoF.png)

    This module will seach in postgresql.conf for port settings, and change it to the
    correct port configuration needed by msfdb (5432), it starts postgresql service and
    check's if the LocalHost its also connected to the correct port (5432), For last it
    check's if msfdb its connected to postgresql, if not, It will then rebuild the msfdb
    (database.yml) exit script execution and leave the postgresql service running.

    This module allows users to config a diferent port (5432) to be used, and a diferent
    postgresql installation path (/etc/postgresql) Users just need to edit the script
    and modify the values 'PoRt' and 'RoOt' in 'Tool variable declarations' funtion.
![postgresql-fix v1.4](http://2.1m.yt/tPOL7Vh.png)


<br /><br />

## Possible errors encounter in configurations
Incorrect postgresql port configuration setting
![Postgresql-fix v1.4](http://1.1m.yt/3FJOy-d.png)
Postgresql selected, no connection ..
![Postgresql-fix v1.4](http://2.1m.yt/So80mg-.png)

<br />

## Improbable script execution errors
Is your postgresql.conf installed in a diferent path? 
![Postgresql-fix v1.4](http://3.1m.yt/WGk3Whl.png)

<br /><br />

## Dependencies/Limitations:
    Zenity, Metasploit, Postgresql, Sed(bash)

    WARNING: Only Linux distros are supported
    WARNING: Only Postgresql versions from 9.1 to 9.7
    WARNING: This toll will NOT fix permanently the issue.
    'Provides a fast way to check/fix the msfdb connection, before using msf'

<br /><br />

## Download/Install/Config:
    1º - Download framework from github
         git clone https://github.com/r00t-3xp10it/postgresql-fix.git

    2º - Set files execution permitions
         cd msfdb-fix
         sudo chmod +x *.sh

    3º - Run main tool
         sudo ./postgresql-fix.sh

<br /><br />

## Video tutorials:
Postgresql-fix [ Official release - Main funtions ]: https://www.youtube.com/watch?v=EGOgzm7fpEk

<br />

### Special thanks:

**Suspicious-Shell-Activity (SSA) RedTeam develop @2017**
