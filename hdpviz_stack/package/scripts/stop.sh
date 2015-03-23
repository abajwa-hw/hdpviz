#!/bin/bash
set -e 

if [[ `ps -ef | grep "server.j[s]" | wc -l` -gt 0 ]] 
then
	echo "Stopping service"
	ps -ef | grep "server.j[s]" | awk '{print $2}' | xargs kill
fi

echo "Done"

