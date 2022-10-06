#!/bin/bash

#cat /home/Documents/laplateforme/FTP/job9/users.csv | while read varligne
#do
 #   password=`echo $varligne |cut -d ',' -f4`
 #   username=`echo $varligne |cut -d ',' -f2`
 #   username=`echo ${username,,}`
 #  role=`echo $varligne |cut -d ',' -f5`
    
 #   if [ ${role:0:5} = "Admin" ]
 #  then
 #       echo "creation de l'utilisateur : $username"
 #       sudo adduser -m $username -p $password
 #       echo "changement du role de : $username"
 #       sudo usermod -aG sudo $username
 #   else 
 #       echo "creation de l'utilisateur : $username"
 #       sudo adduser -m $username -p $password
 #   fi
#done < <(tail -n +2 users.csv)

sudo groupadd ftpadmin

cat ~/Documents/laplateforme/FTP/job9/users.csv | while read varligne
do
    password=`echo $varligne |cut -d ',' -f4`
    ftpuser=`echo $varligne |cut -d ',' -f2`
    ftpuser=`echo ${ftpuser,,}`
    role=`echo $varligne |cut -d ',' -f5`
    
    if [ $role = "Admin" ]
    then
        echo "creation de l'utilisateur : $ftpuser"
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
	sudo useradd -m -p "$pass" "$ftpuser"
        
        echo "changement du role de : $ftpuser"
        sudo usermod -aG sudo $ftpuser
        sudo adduser $ftpuser ftpadmin
    else 
        echo "creation de l'utilisateur : $ftpuser"
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
	sudo useradd -m -p "$pass" "$ftpuser"

    fi
done < <(tail -n +2 users.csv)

