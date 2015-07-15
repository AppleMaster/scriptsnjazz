#!/bin/bash
status=0
MasterHost=""
SlaveHost=""
MasterPass=""
SlavePass=""
DBname=""
GoodMessage="Everything regarding MySQL replication on $SlaveHost is good.\nHave a great day!\n\n"

#Grab the lines for each and use Gawk to get the last part of the string(Yes/No)
SQLresponse=`mysql -u herd_monito -h "$SlaveHost" --password="$SlavePass" "$DBname" -e "show slave status \G" |grep -i "Slave_SQL_Running"|gawk '{print $2}'`
IOresponse=`mysql -u herd_monito -h "$SlaveHost" --password="$SlavePass" "$DBname" -e "show slave status \G" |grep -i "Slave_IO_Running"|gawk '{print $2}'`
LastErr=`mysql -u herd_monito -h "$SlaveHost" --password="$SlavePass" "$DBname" -e "show slave status \G" |grep -i "Last_Error"|gawk '{print $2}'`
LastErrNo=`mysql -u herd_monito -h "$SlaveHost" --password="$SlavePass" "$DBname" -e "show slave status \G" |grep -i "Last_Errno"|gawk '{print $2}'`
SBM=`mysql -u herd_monito -h "$SlaveHost" --password="$SlavePass" "$DBname" -e "show slave status \G" |grep -i "Seconds_Behind_Master"|gawk '{print $2}'`
SIS=`mysql -u herd_monito -h "$SlaveHost" --password="$SlavePass" "$DBname" -e "show slave status \G" |grep -i "Slave_IO_State"|gawk '{print  $2, $3, $4, $5, $6, $7}'`

if [ "$SQLresponse" = "No" ]; then
error="Replication on the slave MySQL server($SlaveHost) has stopped working.\nSlave_SQL_Running: No\n"
status=1
fi

if [ "$IOresponse" = "No" ]; then
error="Replication on the slave MySQL server($SlaveHost) has stopped working.\nSlave_IO_Running: No\n"
status=1
fi

# If the replication is not working
if [ $status = 1 ]; then
echo -e "Error is: "$LastErr""
echo -e "Error No is: "$LastErrNo""
echo "Replication is down."
echo -e $error
fi

# If the replication is working fine
if [ $status = 0 ]; then
echo -e "Seconds Behind Master: "$SBM""
echo -e "Slave State:"$SIS""
echo "Replication is up."
echo -e $GoodMessage
fi
