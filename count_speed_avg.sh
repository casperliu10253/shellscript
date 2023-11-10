#!/bin/bash
read -e -p "media or wangsu domain: " domain
grep -B 1 "$domain" ckspeed.txt | grep -v $domain | sed '/--/d' | awk '{print NR, $0}' > tmp_1.log        #grep -B 1 包含目標上一行 & grep -v 顯示時濾掉指定目標 & awk '{print NR, $0}' 把所有行數加上編號
grep -A 3 "$domain" ckspeed.txt | grep 'elapsed_time' | awk '{print NR, $0}' > tmp_2.log       #grep -A 3 包含目標下面三行 & awk '{print NR, $0}' 把所有行數加上編號
join tmp_1.log tmp_2.log | sed 's/,//' | awk -F' ' '{print $2 " " $3 " " $4}' > $domain.log            # join 指令指定某個欄位為主將 tmp_1.log tmp_2.log 合併 (須加上編碼，類似陣列的概念)  & sed 去除尾巴的 ,  & awk -F' ' 指定分割符印出

read -e -p "insert check date: (ex. 04-20) " date
echo "check date: 2020-$date"
for i in $(seq 18 23)
  do
        cat $domain.log |grep "2020-$date" |grep "/$i:" > "$date-time"$i".txt"
        cat "$date-time"$i".txt"
        awk '{s+=$3}END {printf("sum=%f Average=%f\n",s,s/NR)}' "$date-time"$i".txt"
                #參照 "$date-time"$i".txt" 使用 awk 將第三欄的數字加總 '{s+=$3} 印出總值 sum=%f 印出平均值 Average=%f\n 
                #awk '{s+=$3}END {printf("sum=%f Average=%f\n",s,s/NR)}' 這段拆成幾個部分:
				#1. s+=$3 END 輸出返回變數為 s
				#2. {printf("sum=%f Average=%f\n",s,s/NR)}'  >  雙引號內 "sum=%f Average=%f\n" 屬於字串，並設定字串內為小數點輸出 %f，\n 換行
				#3. {printf("sum=%f Average=%f\n",s,s/NR)}'  >  取得 s 變數內容並印出，平均值的下法為 s/NR
  done
