_y0l0_jack_capture24ch() { date=$(date +%s) ; screen -dmS 1_8 jack_capture -fn "capture_"$date"_1_8.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 9_16 jack_capture -fn "capture_"$date"_9_16.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+9 |head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 17_24 jack_capture -fn "capture_"$date"_17_24.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+17|head -n8|sed 's/^/-p /g') &  echo "all spawned ,  start transport to record to check recording , type screen -ls , then screen -x"; } ;
_y0l0_jack_capture26ch() { date=$(date +%s) ; screen -dmS 1_8 jack_capture -fn "capture_"$date"_1_8.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 9_16 jack_capture -fn "capture_"$date"_9_16.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+9 |head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 17_24 jack_capture -fn "capture_"$date"_17_24.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+17|head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 25_26 jack_capture -fn "capture_"$date"_25_26.flac" -f flac -c 2 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+25 |head -n2|sed 's/^/-p /g') &  echo "all spawned ,  start transport to record to check recording , type screen -ls , then screen -x"; } ;
_ssh_pubkey_authcmd() { echo echo $(cat .ssh/id_rsa.pub |cut -d" " -f1-2) "> ~/.ssh/authorized_keys" ; } ;
_sshfs_arcfour_nocomp() { test -d $s || mkdir -p $2 ; sshfs -o Ciphers=arcfour,Compression=no,auto_cache $1 $2 ; } ;
_last() { last -an400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
_lastn() { last -adn400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
_pico_netmon() { outbuffer=0;reset;while true;do clear;echo "$outbuffer";outbuffer=$( echo "::_pico_netmon";(find /proc /sys/ 2>/dev/null|grep "[tr]x_bytes" |grep -v "net/lo/" | while read a ;do echo $(echo $a |sed "s/.\+net\///g;s/bytes/Mbytes/g")":"$(expr $(cat $a) "/" 1024 "/" 1024);done|sort));sleep 1 ;done  ; };
_wait4file() { wait=0;while ( ! test -e "$1" );do echo -en "\r++"WAITING" for $1 since: "$wait" seconds";sleep 2;let wait+=2;done;echo ; } ;

_ssl_pem_valid_in_future_seconds() { openssl x509 -checkend $2 -noout -in "$1" ; } ; #86400 seconds for one day
_ssl_pem_enddate() { printf '%s: %s\n' "$(date --date="$(openssl x509 -enddate -noout -in "$1"|cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_host_valid_in_future_seconds() { echo | openssl s_client -connect "$1" 2>/dev/null | openssl x509 -checkend $2 -noout  ; } ; #86400 seconds for one day
_ssl_host_enddate() { printf '%s: %s\n' "$(date --date="$( echo | openssl s_client -connect "$1" 2>/dev/null |openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_smtp_valid_in_future_seconds() { echo |openssl s_client -connect "$1" -starttls smtp 2>/dev/null | openssl x509 -checkend $2 ; } ; #86400 seconds for one day
_ssl_smtp_enddate() { printf '%s: %s\n' "$(date --date="$( echo | openssl s_client -connect "$1" -starttls smtp 2>/dev/null | openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_host_enddate_days() {    
end="$(date +%Y-%m-%d --date="$( echo | openssl s_client -connect "$1" 2>/dev/null |openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" ;
date_diff=$(( ($(date -d "$end UTC" +%s) - $(date -d "$(date +%Y-%m-%d) UTC" +%s) )/(60*60*24) ));printf '%s: %s' "$date_diff" "$1" ; } ;


_loadtest_railgun_curl() { echo "TARGET URL:";read URI;echo "number of requests to fork";read rounds;T="$(date +%s)" ;(for i in $( seq 1 $rounds);do (TIMEFORMAT='%3lR' time -p curl -s "$URI" -o /dev/null  2>&1|grep real |tr -d '\n' |sed 's/real/time:/g';echo -n " :: "id $i" ::   | " )  & sleep 0.001;  done;wait );T="$(($(date +%s)-T))";echo ;echo "Time in seconds: ${T}" ; } ;

_ipv6_neighbours_pingall() { exclude=$(ip -6 a|grep fe80|sed 's/inet6 /-e "/g;s/\/.\+/"/g');ip l|cut -d":"  -f2|sed 's/ //g'|cut -d"@" -f1 |while read if ;do ping6 -i1 -c2 ff02::1%$if 2>&1 |grep -v $exclude |while read ping6res ;do host=$(echo $ping6res|grep "bytes from "|cut -d" " -f4|sed 's/:$//g');time=$(echo $ping6res|sed 's/.\+time=//g'|grep ^"[[:digit:]]"|grep -v time |sed 's/ ms//g;s/^/value=/g') ;echo "ipv6_ping_neighbours,target="$(echo -n $host|base64 -w0|tr -cd '[[:alnum:]]')" "$time|grep -v $exclude|grep -v '\= $'  &  done|awk '!x[$0]++'|sort -n|head -n1 ;  done ; } ;
_ipv6_neighbours_pingall_count() { echo $(exclude=$(ip -6 a|grep fe80|sed 's/inet6 /-e "/g;s/\/.\+/"/g');ip l|cut -d":"  -f2|sed 's/ //g'|cut -d"@" -f1 |while read if ;do ping6 -i1 -c2 ff02::1%$if 2>&1 |grep -v $exclude |while read ping6res ;do host=$(echo $ping6res|grep "bytes from "|cut -d" " -f4|sed 's/:$//g');time=$(echo $ping6res|sed 's/.\+time=//g'|grep ^"[[:digit:]]"|grep -v time |sed 's/ ms//g;s/^/value=/g') ;echo "ipv6_ping_neighbours,target="$host" "$time|grep -v $exclude|grep -v '\= $'  &  done|awk '!x[$0]++'|sort -n|head -n1 ;  done|wc -l) ; } ;

_dns_to_json() {  foo=$(dig @4.2.2.4 google.com +nocomments +noquestion +noauthority +noadditional +nostats | awk '{if (NR>3){print}}'| jq -R 'split("\t") |{Name:.[0],TTL:.[2],Class:.[3],Type:.[4],IpAddress:.[5]}' | jq --slurp .) | jq -n --argjson v "$foo" '{"foo": $v}' ; } ;

_private_shell() { which /bin/bash >/dev/null &&  HISTFILE=/dev/null /bin/bash ; } ;
