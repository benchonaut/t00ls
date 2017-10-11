syncdrop() { echo 3|tee /proc/sys/vm/drop_caches > /dev/null ;sync ; } ;
quick_NAT() { iptables -I FORWARD  -j ACCEPT -m state --state NEW,RELATED,ESTABLISHED;iptables -I POSTROUTING -t nat -j MASQUERADE;echo "1" > /proc/sys/net/ipv4/ip_forward ; } ;

