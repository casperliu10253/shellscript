#!/bin/bash

read -e -p "please input the domain(ex. abc.com cde.com): " domain
str=`echo $domain |cut -d '' -f1`

array=($str)

for i in "${!array[@]}"; do
     echo "============= ${array[i]} ==============="
     tmp=`echo "${array[i]}" |cut -d'.' -f2`
        if [ $tmp = "com" ] || [ $tmp = "net" ] || [ $tmp = "edu" ] || [ $tmp = "cc" ]; then
           whois ${array[i]} |grep "Registry Expiry Date"

        elif [ $tmp = "cn" ]; then
           whois ${array[i]} |grep "Expiration Time"

        else
           echo "unknown type, please add the key word"
           whois ${array[i]}

       fi

          dig ns +noall +answer @1.1.1.1 ${array[i]}
          dig +noall +answer @1.1.1.1 ${array[i]}
          dig cname +noall +answer @1.1.1.1 ${array[i]}

done
