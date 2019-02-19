_y0l0_jack_capture24ch() { date=$(date +%s) ; screen -dmS 1_8 jack_capture -fn "capture_"$date"_1_8.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 9_16 jack_capture -fn "capture_"$date"_9_16.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+9 |head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 17_24 jack_capture -fn "capture_"$date"_17_24.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+17|head -n8|sed 's/^/-p /g') &  echo "all spawned ,  start transport to record to check recording , type screen -ls , then screen -x"; } ;
_y0l0_jack_capture26ch() { date=$(date +%s) ; screen -dmS 1_8 jack_capture -fn "capture_"$date"_1_8.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 9_16 jack_capture -fn "capture_"$date"_9_16.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+9 |head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 17_24 jack_capture -fn "capture_"$date"_17_24.flac" -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+17|head -n8|sed 's/^/-p /g') & sleep 0.1;screen -dmS 25_26 jack_capture -fn "capture_"$date"_25_26.flac" -f flac -c 2 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+25 |head -n2|sed 's/^/-p /g') &  echo "all spawned ,  start transport to record to check recording , type screen -ls , then screen -x"; } ;
_ssh_pubkey_authcmd() { echo echo $(cat .ssh/id_rsa.pub |cut -d" " -f1-2) "> ~/.ssh/authorized_keys" ; } ;
_sshfs_arcfour_nocomp() { test -d $s || mkdir -p $2 ; sshfs -o Ciphers=arcfour,Compression=no,auto_cache $1 $2 ; } ;
_last() { last -an400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
_lastn() { last -adn400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
_pico_netmon() { outbuffer=0;reset;while true;do clear;echo "$outbuffer";outbuffer=$( echo "::_pico_netmon";(find /proc /sys/ 2>/dev/null|grep "[tr]x_bytes" |grep -v "net/lo/" | while read a ;do echo $(echo $a |sed "s/.\+net\///g;s/bytes/Mbytes/g")":"$(expr $(cat $a) "/" 1024 "/" 1024);done|sort));sleep 1 ;done  ; };

_ssl_pem_valid_in_future_seconds() { openssl x509 -checkend $2 -noout -in "$1" ; } ; #86400 seconds for one day
_ssl_pem_enddate() { printf '%s: %s\n' "$(date --date="$(openssl x509 -enddate -noout -in "$1"|cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_host_valid_in_future_seconds() { echo | openssl s_client -connect "$1" 2>/dev/null | openssl x509 -checkend $2 -noout  ; } ; #86400 seconds for one day
_ssl_host_enddate() { printf '%s: %s\n' "$(date --date="$( echo | openssl s_client -connect "$1" 2>/dev/null |openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_smtp_valid_in_future_seconds() { echo |openssl s_client -connect "$1" -starttls smtp 2>/dev/null | openssl x509 -checkend $2 ; } ; #86400 seconds for one day
_ssl_smtp_enddate() { printf '%s: %s\n' "$(date --date="$( echo | openssl s_client -connect "$1" -starttls smtp 2>/dev/null | openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_host_enddate_days() {    
end="$(date +%Y-%m-%d --date="$( echo | openssl s_client -connect "$1" 2>/dev/null |openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" ;
date_diff=$(( ($(date -d "$end UTC" +%s) - $(date -d "$(date +%Y-%m-%d) UTC" +%s) )/(60*60*24) ));printf '%s: %s' "$date_diff" "$1" ; } ;

