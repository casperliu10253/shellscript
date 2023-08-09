#!/bin/bash

CF_TOKEN="api key (123456)"
CF_ACCOUNT="email (123456@gmail.com)"

null=""

echo "(1)show domain records 
(2)add a new record 
(3)delete record 
(4)re-type the record
(5)create a new domain for cloudflare"

read -e -p "your select: " selector
read -e -p "please insert main domain name: " zone

############ 查詢 cloudflare domain ############
if [ $selector = 1 ]; then
   echo "Usage: cloudflare show records <zone>"
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone

############ 建立 domain record ############
elif [ $selector = 2 ]; then
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone
   echo "Usage: cloudflare add record <zone> <type> <name> <content> [ttl] [prio] [service] [protocol] [weight] [port] "
   echo "<zone>      domain zone to register the record in, see 'show zones' command"
   echo "<type>      one of: A, AAAA, CNAME, MX, NS, SRV, TXT, SPF, LOC"
   echo "<name>      subdomain name, or "@" to refer to the domain's root"
   echo "<content>   IP address for A, AAAA"
   echo "            FQDN for CNAME, MX, NS, SRV"
   echo "            any text for TXT, spf definition text for SPF"
   echo "            coordinates for LOC (see RFC 1876 section 3)"

   read -e -p "please insert type: " type2
   read -e -p "please insert subdomain or @ : " sub2
   read -e -p "please insert content (ex. IP address or FQDN): " content2
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN add record $zone $type2 $sub2 $content2
   echo "main domain: $zone"
   echo "Usage: cloudflare show records <zone>"
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone

############ 刪除 domain record ############
elif [ $selector = 3 ]; then
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone
   echo "Usage: cloudflare delete record [<record-name> [<record-type> | first] | [<zone-name>|<zone-id>] <record-id>]"
   echo "ex. cloudflare delete record ftp.example.net"
   read -e -p "please insert subdomain or @ for delete: " recordname3
   read -e -p "please insert record type for delete: " recordtype3
     if [ $recordname3 = $null ] || [ $recordtype3 = $null ]; then
        echo "domain or record is null!! the end!!"
        exit
     fi

   echo "your type: $recordname3".$zone""
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN delete record "$recordname3".$zone"" $recordtype3 $zone
   echo "main domain: $zone"
   echo "Usage: cloudflare show records <zone>"
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone

############ 重建 domain record ############
elif [ $selector = 4 ]; then
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone

   echo "Usage: cloudflare delete record [<record-name> [<record-type> | first] | [<zone-name>|<zone-id>] <record-id>]"
   echo "ex. cloudflare delete record ftp.example.net"

   read -e -p "please insert subdomain or @ for delete: " recordname5
   read -e -p "please insert record type for delete: " recordtype5
     if [ $recordname5 = $null ] || [ $recordtype5 = $null ]; then
        echo "domain or record is null!! the end!!"
        exit
     fi


   echo "your type: $recordname5".$zone""
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN delete record "$recordname5".$zone"" $recordtype5 $zone

   echo "Usage: cloudflare add record <zone> <type> <name> <content> [ttl] [prio] [service] [protocol] [weight] [port] "
   echo "<zone>      domain zone to register the record in, see 'show zones' command"
   echo "<type>      one of: A, AAAA, CNAME, MX, NS, SRV, TXT, SPF, LOC"
   echo "<name>      subdomain name, or "@" to refer to the domain's root"
   echo "<content>   IP address for A, AAAA"
   echo "            FQDN for CNAME, MX, NS, SRV"
   echo "            any text for TXT, spf definition text for SPF"
   echo "            coordinates for LOC (see RFC 1876 section 3)"

   read -e -p "please insert type: " type5
   read -e -p "please insert subdomain or @ : " sub5
   read -e -p "please insert content (ex. IP address or FQDN): " content5
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN add record $zone $type5 $sub5 $content5
   echo "main domain: $zone"
   echo "Usage: cloudflare show records <zone>"
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone

############ 在 cloudflare 上建立一個新的 domain(zone) ############
elif [ $selector = 5 ]; then
   echo "main domain: $zone"
   echo "Usage: cloudflare add zone <name>"
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN add zone $zone
   echo "Usage: cloudflare show records <zone>"
   /root/cloudflare-cli/cloudflare -E $CF_ACCOUNT -T $CF_TOKEN show records $zone

else 
   echo "wrong type!!"

fi   
