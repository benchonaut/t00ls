_y0l0_jack_capture24ch() { date=$(date +%s) ; screen -dmS 18 jack_capture -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|head -n8|sed 's/^/-p /g') & screen -dmS 916 jack_capture -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+9 |head -n8|sed 's/^/-p /g') & screen -dmS 1724 jack_capture -f flac -c 8 -jt $(jack_lsp|grep ^sys|grep capt|tail -n+17|head -n8|sed 's/^/-p /g') &  echo "all spawned ,  start transport to record to check recording , type screen -ls , then screen -x"; } ;
_ssh_pubkey_authcmd() { echo echo $(cat .ssh/id_rsa.pub |cut -d" " -f1-2) "> ~/.ssh/authorized_keys" ; } ;
_sshfs_arcfour_nocomp() { test -d $s || mkdir -p $2 ; sshfs -o Ciphers=arcfour,Compression=no,auto_cache $1 $2 ; } ;
_last() { last -an400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
_lastn() { last -adn400 |sed 's/^\([a-zA-Z0-9]\)[a-zA-Z0-9]\+/\1***/g;s/ \+/ /g;s/\t/ /g;s/mux/µ/g' ; } ;
