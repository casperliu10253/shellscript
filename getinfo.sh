#!/bin/bash
echo "---------------------------------------------------"
read -e -p "Please input app or wap: " type

read -e -p "Please input customer brand: " brand_name

str=`ls -d /root/test/$type/"$brand_name"*$type/ | cut -d ' ' -f 1-`     ## 將輸出結果切掉空白後丟入 $str

array=($str)                                                            ## 丟入陣列
for i in "${!array[@]}"; do                                       ## for 迴圈輸出所有搜尋結果
	echo "($i) ${array[i]}"
done

if [ $i -ne "0" ] ;then                                               ## 如果 $i 不等於 0 執行下列程式   (搜尋結果超過一個)
read -e -p "please choose: " choose

	grep --color server_name ${array[choose]}/vhost/*
        echo "---------------------------------------------------"
        grep --color "\$zuul " ${array[choose]}/vhost/public.block
        echo "---------------------------------------------------"
        grep --color "\$cdndomain " ${array[choose]}/vhost/*

elif [ $i -eq "0" ]; then                                                           ##如果 $i 等於 0 執行下列程式 (搜尋結果只有一個)
        grep --color server_name ${array[$i]}/vhost/*
        echo "---------------------------------------------------"
        grep --color "\$zuul " ${array[$i]}/vhost/public.block
        echo "---------------------------------------------------"
        grep --color "\$cdndomain " ${array[$i]}/vhost/*

else  
	echo "wrong type name or wrong client name"
 
fi
#$ 必須使用反斜線才可以當作字串，否則會變成變數
