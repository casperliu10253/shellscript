#!/bin/bash

echo "please insert domain (ex. abc1.com abc2.com): "
read -e test
echo $test > /root/domainlist
echo "your domain list: "
str=`cat /root/domainlist | cut -d ' ' -f 1-`   #第二段讀字串用以空格為分隔基準把所有資料印出
echo "-------------------------------------------------"

array=($str)
for i in "${!array[@]}"; do
    echo "${array[i]}"
    echo "${array[i]}" >> /root/diglist
done

while read -p "Please choose dig method [1]dig full [2]dig +trace :" num
do
  if [[ -n $num ]]; then
    break;
  fi
done

filename='/root/diglist'
exec < $filename
   if [[ $num = 1 ]]; then
   while read line
      do
        echo "================ $line ================"
      dig ns +noall +answer @1.1.1.1 $line
      dig +noall +answer @1.1.1.1 $line
      dig cname +noall +answer @1.1.1.1 $line
      done
   
   elif [[ $num = 2 ]]; then
      while read line
      do
          echo "================ $line trace ================"
          dig +trace +tcp +noall +answer @1.1.1.1 $line
      done

  fi

rm -rf /root/diglist
