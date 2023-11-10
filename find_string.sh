#!/bin/bash
read -e -p "Please input search string: " search_name
read -e -p "Please input app or wap: " type
echo "your searching: $search_name"
echo "---------------------------------------------------"
  if [ "$type" == "app" ] || [ "$type" == "wap" ];then
    cd /root/test/$type/ ; grep --color -rl $search_name 
    echo "---------------------------------------------------"

  else 
    echo "Please input the correct type app or wap"

  fi 
