#!/bin/sh
##
# Version release: v1.1 (Stable)
# Author: pedr0 Ubuntu [r00t-3xp10it]
# codename: Metasploit_postgresql_database_connection_fix
# Distros Supported : Linux Ubuntu, Kali, Mint, Parrot OS
# Suspicious-Shell-Activity (SSA) RedTeam develop @2017
# ---
# [DESCRIPTION]
# This tool will try to quickly fix the metasploit postgresql connection bug,
# present in postgresql.conf install versions from 9.1 to 9.7 (Incorrect port settings).
# 'Just run it before using metasploit to check settings OR fix msfdb connection errors'
#
# This module will seach in postgresql.conf for port settings, and change it to the
# correct port configuration needed by msfdb (5432), it starts postgresql service and
# check's if the LocalHost its also connected to the correct port (5432), For last it
# check's if msfdb its connected to postgresql, if not, It will then rebuild the msfdb
# (database.yml) exit script execution and leave the postgresql service running.
#
# This module allows users to config a diferent port (5432) to be used, and a diferent
# postgresql installation path (/etc/postgresql) Users just need to edit the script
# and modify the values 'PoRt' and 'RoOt' in 'Tool variable declarations' funtion.
# ---
# [DEPENDENCIES]
# Zenity | Metasploit | Postgresql | Sed(bash)
##



#
# Tool variable declarations ______
#                                  |
VeR="1.1"                          # Script version number
PoRt="5432"                        # Port used by metasploit to connect to postgresql
RoOt="/etc/postgresql"             # Path to postgresql instalation (version search)
SeRvIcE="service postgresql start" # Command used to start the postgresql service
##_________________________________|



#
# Resize terminal windows size before running the tool (gnome terminal)
# Special thanks to h4x0r Milton@Barra for this little piece of heaven! :D
#
resize -s 26 92 > /dev/null



#
# Colorise shell Script output leters
#
Colors() {
Escape="\033";
  white="${Escape}[0m";
  RedF="${Escape}[31m";
  GreenF="${Escape}[32m";
  YellowF="${Escape}[33m";
  BlueF="${Escape}[34m";
  CyanF="${Escape}[36m";
Reset="${Escape}[0m";
}



#
# Tool main Banner display
#
Colors;
echo ${BlueF}
cat << !
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---+
    |p|o|s|t|g|r|e|s|q|l|-|f|i|x|:|$VeR|
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---+
    Author: r00t-3xp10it [ssa-red_team]

!



  #
  # Store postgresql.conf full PATH into one bash variable ..
  # Only the lastest version installed of postgresql will be locked ..
  #
  echo ${BlueF}[☆]${white}" Storing postgresql.conf full path .."${Reset};

    #
    # Trying to locate the latest version installed ..
    #
    path=`locate postgresql.conf | grep "/etc" | grep "9.1"`
    if [ "$path" = "$RoOt/9.1/main/postgresql.conf" ]; then
      postgresql_path="$RoOt/9.1/main/postgresql.conf"
    fi
    path=`locate postgresql.conf | grep "/etc" | grep "9.2"`
    if [ "$path" = "$RoOt/9.2/main/postgresql.conf" ]; then
      postgresql_path="$RoOt/9.2/main/postgresql.conf"
    fi
    path=`locate postgresql.conf | grep "/etc" | grep "9.3"`
    if [ "$path" = "$RoOt/9.3/main/postgresql.conf" ]; then
      postgresql_path="$RoOt/9.3/main/postgresql.conf"
    fi
    path=`locate postgresql.conf | grep "/etc" | grep "9.4"`
    if [ "$path" = "$RoOt/9.4/main/postgresql.conf" ]; then
      postgresql_path="$RoOt/9.4/main/postgresql.conf"
    fi
    path=`locate postgresql.conf | grep "/etc" | grep "9.5"`
    if [ "$path" = "$RoOt/9.5/main/postgresql.conf" ]; then
      postgresql_path="$RoOt/9.5/main/postgresql.conf"
    fi
    path=`locate postgresql.conf | grep "/etc" | grep "9.6"`
    if [ "$path" = "$RoOt/9.6/main/postgresql.conf" ]; then
      postgresql_path="$RoOt/9.6/main/postgresql.conf"
    fi
    path=`locate postgresql.conf | grep "/etc" | grep "9.7"`
    if [ "$path" = "$RoOt/9.7/main/postgresql.conf" ]; then
      postgresql_path="$RoOt/9.7/main/postgresql.conf"
    fi
    #
    # Confirm if the tool has stored correctly the postgresql.conf full PATH ..
    #
    if ! [ -e "$postgresql_path" ]; then
      echo ${RedF}[x]${white}" Postgresql.conf path not found .."${Reset};
      sleep 1
      echo ${RedF}[x]${white}" Path sellected": $RoOt ${Reset};
      sleep 2
      echo ${RedF}[x]${white}" Script execution aborted .."${Reset};
      sleep 1
      echo ${BlueF}[☆]${white}" Edit this script and change the 'RoOt' variable .."${Reset};
      sleep 1
      # Abort script execution ..
      exit
    fi
    #
    # Display to user the posgresql (latest version) full path locked ..
    #
    echo ${GreenF}[✔]${white}" Path": $postgresql_path ${Reset};
    sleep 1



    #
    # Store postgresql PORT used into one bash variable ..
    #
    echo ${BlueF}[☆]${white}" Storing postgresql port configuration .."${Reset};
    port=`grep "port =" $postgresql_path | awk {'print $3'}`
    sleep 1

      if [ "$port" != "$PoRt" ]; then
      #
      # Postgresql Incorrect PORT configuration found ..
      #
      echo ${RedF}[x]${white}" Postgresql Incorrect port configuration .."${Reset};
      sleep 1
      echo ${RedF}[x]${white}" Postgresql Port found: $port .."${Reset};
      sleep 1
        #
        # Use SED(bash) to replace the PORT number in postgresql.conf ..
        #
        echo ${RedF}[x]${white}" Replacing port number in postgresql.conf .."${Reset};
        sed -i "s|port = $port|port = $PoRt|" $postgresql_path
        sleep 1
        # Re-define PORT variable(bash) to be used further ahead ..
        port="$PoRt"
        echo ${GreenF}[✔]${white}" Postgresql port": $port ${Reset};
        sleep 1
      else
        #
        # All good in postgresql PORT settings found ..
        #
        echo ${GreenF}[✔]${white}" Postgresql port": $port ${Reset};
        sleep 1
      fi


#
# Start postgresql service ..
#
echo ${BlueF}[☆]${white}" Starting postgresql service .."${Reset};
$SeRvIcE | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Starting postgresql service .." --percentage=0 --auto-close --width 300 > /dev/null 2>&1
echo ${GreenF}[✔]${white}" Service postgresql running .."${Reset};
sleep 1


  #
  # Check if correct PORT its open (LocalHost)
  #
  echo ${BlueF}[☆]${white}" Checking LocalHost connection status .."${Reset};
  check=`ss -ant | grep "127" | grep "$port" | awk {'print $4'} | cut -d ':' -f2`
  print=`ss -ant | grep "127" | grep "$port" | awk {'print $4'}`
  # Not found == Display all configurations active ..
  nill=`ss -ant | grep "127" | awk {'print $4'}`
  sleep 1


    if [ "$check" != "$port" ]; then
      #
      # LocalHost Incorrect configuration found ..
      # (LocalHost) postgresql PORT open not found, aborting tasks ..
      #
      echo ${RedF}[x]${white}" LocalHost Incorrect configuration found .."${Reset};
      echo ${RedF}[x]${white}" LocalHost settings: $nill "${Reset};
      sleep 1
      echo ${RedF}[x]${white}" Script execution aborted .."${Reset};
      # Abort script execution ..
      exit

    else

        #
        # All good in postgresql PORT open (LocalHost) ..
        # Start msfconsole to check postgresql connection status
        #
        echo ${GreenF}[✔]${white}" LocalHost settings: $print "${Reset};
        sleep 1
        echo ${BlueF}[☆]${white}" Checking msfdb connection status .."${Reset};
        ih=`msfconsole -q -x 'db_status; exit -y' | awk {'print $3'}`

          #
          # Postgresql selected, no connection ..
          #
          if [ "$ih" != "connected" ]; then
            echo ${RedF}[x]${white}" postgresql selected, no connection .."${Reset};
            echo ${RedF}[x]${white}" Please wait, rebuilding msf database .."${Reset};
            sleep 1
            #
            # Rebuild msf database (database.yml)
            #
            echo ""
            msfdb reinit | zenity --progress --pulsate --title "☠ PLEASE WAIT ☠" --text="Rebuild metasploit database" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
            echo ""
            echo ${GreenF}[✔]${white}" postgresql connected to msf .."${Reset};
            sleep 1
          else
            #
            # All good in Postgresql connection to Metasploit database ..
            #
            echo ${GreenF}[✔]${white}" postgresql connected to msf .."${Reset};
            sleep 1
          fi
    fi



#
# The end ..
#
echo ${BlueF}[☆]${white}" Script execution completed .."${Reset};
sleep 1
echo ""
echo ${white}"    Author${BlueF}::${white}pedr0 ubuntu${BlueF}::${white}[r00t-3xp10it]"${Reset};
echo ${white}"    Codename${BlueF}::${white}Metasploit_postgresql_database_connection_fix"${Reset};
echo ${white}"    postgresql-fix${BlueF}::${white}v$VeR${BlueF}::${white}SuspiciousShellActivity©${BlueF}::${white}RedTeam${BlueF}::${white}2017"${Reset};
echo ""
exit

