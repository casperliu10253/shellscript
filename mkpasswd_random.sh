#!/bin/bash

read -e -p "please input the domain name: " domain
read -e -p "the encrypt length is?(ex. 10): " length
echo "-------------------------------------------"
read -e -p "how many times do you need?(ex. 2): " runtimes

for i in `seq $runtimes` 
do
  if [[ $length -gt 0 ]] ; then
        ramdom=`mkpasswd -l $length -d 1 -c 1 -s 0 -C 0`
        echo "$ramdom.$domain"
  else
        echo "please input the number!"

  fi
done
