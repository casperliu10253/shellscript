#!/bin/bash
rm -rf /root/casper/findconfig

read -e -p "please input group ID: " groupname
echo "=============== $groupname ==============="

############  尋找設定檔內字串並丟入陣列，其中加入了 如果有 *cp 開頭的字串有另外判斷並列出 ############ 
cat /root/casper/"$groupname"_list > /root/casper/grouplist
str=`cat /root/casper/grouplist`
  array1=($str)
    for i in "${!array1[@]}"; do
      echo "${array1[i]}"
      if [[ ${array1[i]} = *"cp"  ]];then
        awslist=`echo "${array1[i]}" |cut -c 1-2`
        find /root/oss-config/* -name "$awslist".conf -type f >> /root/casper/findconfig
      else
        awslist=`echo "${array1[i]}"`
        find /root/oss-config/* -name "$awslist".conf -type f >> /root/casper/findconfig
      fi  
 
    done

############ 列出設定檔並判斷是否為空值  ############
echo "=============== found config  ==============="
config=`cat /root/casper/findconfig`

if [[ $config = "" ]]; then
     echo "config not found"
     exit
fi

############ 使用 ossutil64 的 script 進行 aliyun oss 的資料下載  ############
path=`echo "/data/wwwroot/oss-$groupname-hk"`

   array2=($config)
   
    for c in "${!array2[@]}"; do
      oss1=`echo "oss://${array1[c]}-cdn"`
      echo "/root/oss-config/ossutil64 -c ${array2[c]} cp -r $oss1 "$path/${array1[c]}-cdn/" --update"
      /root/oss-config/ossutil64 -c ${array2[c]} cp -r $oss1 "$path/${array1[c]}-cdn/" --update
      
    done
echo "============================================="


############  使用 ossutil64 的 script 進行 aliyun oss 的資料上傳  ############
read -e -p "do you wanna upload? (y/n) " yesno

groupconf=`echo "/root/oss-config/$groupname-hk.conf"`

if [ $yesno = "y" ] || [ $yesno = "Y" ]; then
   oss2=`echo "oss://$groupname-hk-oss"`
   echo "記得到 aliyun 帳號開啟 "公共雲讀寫""
   echo "============================================="
   sleep 5
   echo "/root/oss-config/ossutil64 -c $groupconf cp -r "$path/" $oss2 --update"
   /root/oss-config/ossutil64 -c $groupconf cp -r "$path/" $oss2 --update
   echo "上傳完成!! 記得到 aliyun 帳號設定為 "公共雲只讀取" "
elif [ $yesno = "n" ] || [ $yesno = "N" ]; then
   echo "殘念!!"

else
   echo "Please type Y/N !!"

fi
