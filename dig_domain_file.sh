while read -p "Please choose dig method [1]dig a [2]dig cname [3]dig ns [4]dig +trace [5]dig short: " num
do
  if [[ -n $num ]]; then
    break;
  fi
done

filename='/root/diglist'
if [[ $num = 1 ]]; then
        exec < $filename
        while read line
            do
                echo "$line"
                echo "---------------------------------------"
                dig +noall +answer @1.1.1.1 $line
                echo "---------------------------------------"

            done
fi
rm -rf /root/diglist
