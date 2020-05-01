#!/bin/bash

sed -i -e 's/\# DaemonPort = .*/DaemonPort = '"${BITLBEE_PORT}"'/' /etc/bitlbee/bitlbee.conf
/usr/sbin/bitlbee -F -n
