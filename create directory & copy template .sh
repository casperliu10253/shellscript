#!/bin/bash

echo "----------------------------------"
echo "(1)Create New Directory (2)Copy Template (3)Create a vhost New Config file "
read -e -p "Please Choose What You Need: " choose

if [ $choose = 1 ]; then
   read -e -p "the directory will create to app or wap? " type1

########### 比對輸入 app 還是 wap 後，建立新的 directory ###########
     if [ $type1 = app ] || [ $type1 = wap ]; then
      read -e -p "please input the directory name: " dirname1
      mkdir /root/test/$type1/$dirname1
      echo "/root/test/$type1/$dirname1 has been create!!"

     read -e -p "do you need copy the template to new directory? please type (y/n) " yes_or_no
       if [ $yes_or_no = yes ] || [ $yes_or_no = y ]; then
          cp /root/test/nginx_template/$type1"_template"/* /root/test/$type1/$dirname1 -R
          echo "copy to /root/test/$type1/$dirname1 completed!"
       else
          echo "You don't need copy template~"
       fi

     else
      echo "please input the app or wap!"
     fi

elif [ $choose = 2 ]; then 
    read -e -p "do you wanna copy app or wap template? " type2
     if [ $type2 = app ] || [ $type2 = wap ]; then
      read -e -p "please input the directory name: " dirname2
      cp /root/test/nginx_template/$type2"_template"/ /root/test/$type2/$dirname2 -R
      echo "copy to /root/test/$type2/$dirname2 completed!"
    else
      echo "please input the app or wap!"
    fi

elif [ $choose = 3 ]; then
    read -e -p "do you wanna create app or wap? " type3
     if [ $type3 = app ] || [ $type3 = wap ]; then
      read -e -p "please input the filename: " filename
      read -e -p "please input the brand ID: " brand3
      read -e -p "please input the server_name's domain: " server_name3
     cp /root/test/nginx_template/$type3"_template"/vhost/temp_"$type3"*.conf /root/test/$type3/$brand3/vhost/"$filename".conf
     sed -i "s/server_name /server_name ${server_name3}/g" /root/test/$type3/$brand3/vhost/"$filename".conf
     echo "/root/test/$type3/$brand3/vhost/"$filename".conf has been created!"

         sed -i "s/nginx\/conf\/ssl\/.pem/nginx\/conf\/ssl\/${filename}.pem/g" /root/test/$type3/$brand3/vhost/"$filename".conf
         sed -i "s/nginx\/conf\/ssl\/.key/nginx\/conf\/ssl\/${filename}.key/g" /root/test/$type3/$brand3/vhost/"$filename".conf

     echo "/root/test/$type3/$brand3/vhost/"$filename".conf has been modified!" 
     else
      echo "please input the app or wap!"
     fi
 
else
   echo "wrong!! please the select wrong!"

fi
