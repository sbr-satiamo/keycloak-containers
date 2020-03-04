#!/bin/bash -e

###########################
# add specific ip table rules - restrict shared loadbalancer #
###########################

iptables -I INPUT 1 -s 10.130.0.5/32 -j DROP 
iptables -I INPUT 1 -s 10.130.0.6/32 -j DROP

echo "iptables executed " > /root/iptables_echo