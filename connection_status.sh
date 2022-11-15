#!/bin/bash
file=/home/euronet/.local/bin/ip.txt
while read line
do
  ip=$( echo "$line" |cut -d ' ' -f 1 )
  port=$( echo "$line" |cut -d ' ' -f 2 )
  customer=$( echo "$line" |cut -d ' ' -f 3 )
  if timeout 2  telnet $ip $port </dev/null 2>&1 | grep -q Escape
  then
    echo "$ip $port $customer Connected"
  elif  timeout 2 telnet  $ip $port </dev/null 2>&1 | grep -q refused
  then
    echo "$ip $port $customer Refused"
  else
    echo "$ip $port $customer Failed"
  fi
done < ${file}
exit
