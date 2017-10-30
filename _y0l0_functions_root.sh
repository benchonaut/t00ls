syncdrop() { echo 3|tee /proc/sys/vm/drop_caches > /dev/null ;sync ; } ;
_quick_NAT() { iptables -I FORWARD  -j ACCEPT -m state --state NEW,RELATED,ESTABLISHED;iptables -I POSTROUTING -t nat -j MASQUERADE;echo "1" > /proc/sys/net/ipv4/ip_forward ; } ;
_ssh_rsa8192_serverkey() { du -b /etc/ssh/ssh_host_rsa_key|grep ^636[0-9] && echo is 8192 || ssh-keygen -t rsa -b 8192 -f /etc/ssh/ssh_host_rsa_key -N ""; }


