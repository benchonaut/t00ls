#!/bin/bash
_syncdrop_hard() { echo 3|tee /proc/sys/vm/drop_caches > /dev/null ;sync ; } ;
_syncdrop_soft() { echo 2|tee /proc/sys/vm/drop_caches > /dev/null ;sync ; } ;
_syncdrop() { syncdrop_soft ; } ;
_quick_NAT() { iptables -I FORWARD  -j ACCEPT -m state --state NEW,RELATED,ESTABLISHED;iptables -I POSTROUTING -t nat -j MASQUERADE;echo "1" > /proc/sys/net/ipv4/ip_forward ; } ;
_ssh_rsa8192_serverkey() { du -b /etc/ssh/ssh_host_rsa_key|grep ^636[0-9] && echo is 8192 || ssh-keygen -t rsa -b 8192 -f /etc/ssh/ssh_host_rsa_key -N ""; }


_docker_containers_remove_exited() { ( sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm ) ; } ;

_docker_containers_memory_find_exhausted() { docker ps -a |sed 's/ \+/ /g'|cut -d" " -f1,2|while read a ;do echo -n $a":";docker container inspect $(echo $a|cut -d" " -f1) -f '{{json .State.OOMKilled}}' 2>&1 ;done|grep true ;echo ; } ; 


_docker_containers_memory_find_oomkilled() { _docker_containers_memory_find_exhausted ; } ;



_docker_containers_memory_top20() { watch 'docker stats --format "table {{.MemPerc}}\t{{.MemUsage}}\t{{.Name}}" --no-stream --no-trunc|grep -v -e ^0.00 -e ^CPU|sort -nsr|head -n20' ; } ;

_docker_mysql_status() { docker ps -a --format '{{.Names}} {{.Image}} {{.Status}}' |grep -v redirect|grep -v -e memcache -e nginx -e redis -e portainer|grep -v Exited|cut -d" " -f1|while read a ; do echo "########";echo $a;docker exec -t $a /bin/bash -c "test -f /etc/init.d/mysql && /etc/init.d/mysql status |grep -e Uptime: -e Threads:";done ; } ;

_docker_containers_cpu_top20() { watch 'docker stats --format "table {{.CPUPerc}}\t{{.Name}}" --no-stream --no-trunc|grep -v -e ^0.00 -e ^CPU|sort -nsr|head -n20' ; } ;


_docker_remove_images_dangling() { docker rmi $(docker images -f "dangling=true" -q) ; } ;
_docker_images_dangling() { docker images -f "dangling=true" -q ; } ;

_docker_clean_caches_hard() { docker system prune -a ; } ; 


_docker_this_restart() { docker restart $(basename $(pwd)) ; } ;
_docker_this_logs_follow() { docker logs -f $(basename $(pwd)) --since 1s ; } ;
_docker_this_logs_follow_5m() { docker logs -f $(basename $(pwd)) --since 5m ; } ;
_docker_this_logs_follow_10m() { docker logs -f $(basename $(pwd)) --since 10m ; } ;

_docker_this_mysql_real() { docker exec -t $(basename $(pwd)) mysql "$@" ; } ;
_docker_this_mysql_console() { docker exec -t $(basename $(pwd)) mysql "$@" ; } ;


