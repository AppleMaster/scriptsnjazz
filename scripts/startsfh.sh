#!/bin/bash
status=0
MasterHost=""
SlaveHost=""
SlavePass=""
DBname=""

echo "Stopping replication on "$SlaveHost""
StopSlave=`mysql -u herd_monito -h "$SlaveHost" --password="$SlavePass" "$DBname" -e "start slave;" |grep -i "Query OK"|gawk '{print $0, $1, $2, $3, $4, $5, $6, $7, $8, $9}'`
echo -e "Started slave."
echo -e "Have a nice day"