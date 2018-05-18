_y0l0_jack_capture24ch() { date=$(date +%s) ; screen -dmS 18 jack_capture -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|head -n8|sed 's/^/-p /g') & screen -dmS 916 jack_capture -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+9 |head -n8|sed 's/^/-p /g') & screen -dmS 1724 jack_capture -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+17|head -n8|sed 's/^/-p /g') &  echo "all spawned ,  start transport to record to check recording , type screen -ls , then screen -x"; } ;
_ssh_pubkey_authcmd() { echo echo $(cat .ssh/id_rsa.pub |cut -d" " -f1-2) "> ~/.ssh/authorized_keys" ; } ;
_sshfs_arcfour_nocomp() { test -d $s || mkdir -p $2 ; sshfs -o Ciphers=arcfour,Compression=no,auto_cache $1 $2 ; } ;
_last() { last -an400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
_lastn() { last -adn400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
_ssl_pem_valid_in_future_seconds() { openssl x509 -checkend $2 -noout -in "$1" ; } ; #86400 seconds for one day
_ssl_pem_enddate() { printf '%s: %s\n' "$(date --date="$(openssl x509 -enddate -noout -in "$1"|cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_host_valid_in_future_seconds() { echo | openssl s_client -connect "$1" 2>/dev/null | openssl x509 -checkend $2 -noout  ; } ; #86400 seconds for one day
_ssl_host_enddate() { printf '%s: %s\n' "$(date --date="$( echo | openssl s_client -connect "$1" 2>/dev/null |openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
_ssl_smtp_valid_in_future_seconds() { echo |openssl s_client -connect "$1" -starttls smtp 2>/dev/null | openssl x509 -checkend $2 ; } ; #86400 seconds for one day
_ssl_smtp_enddate() { printf '%s: %s\n' "$(date --date="$( echo | openssl s_client -connect "$1" -starttls smtp 2>/dev/null | openssl x509 -enddate -noout |cut -d= -f 2)" --iso-8601)" "$1"  ; } ; 
