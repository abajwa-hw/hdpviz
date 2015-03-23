#!/bin/bash
set -e 
INSTALL_DIR=$1
LOG_FILE=$2
PID_FILE=$3

PID_DIR=$(dirname "$PID_FILE")

if [ ! -d "$PID_DIR" ]
then
	echo "Creating PID_DIR: $PID_DIR"
	mkdir -p $PID_DIR
fi

#If service already started, skip the start
SERVICE_PIDS=`ps -ef | grep "server.j[s]" | wc -l`
if [ $SERVICE_PIDS -eq 0 ]
then
	echo "Service not running. Starting service in background..."
	cd $INSTALL_DIR/HDP-Viz
	nohup node server/server.js	>> $LOG_FILE 2>&1 &
	echo $! > $PID_FILE
else
	echo "Service already running..."
fi


