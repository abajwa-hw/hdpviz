#!/bin/bash
set -e 

#return 0 only if service is up
echo "Checking status...."

SERVICE_PIDS=`ps -ef | grep "server.j[s]" | wc -l`
if [ $SERVICE_PIDS -eq 0 ]
then
	echo "Service not running..."
	exit 1
else
	PID=`ps -ef | grep "server.j[s]" | awk '{print $2}'`
	echo "hdpviz (pid  $PID) is running..."
	exit 0
fi



