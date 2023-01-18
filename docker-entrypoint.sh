#!/bin/sh

if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "Please specify a host and port, e.g. localhost 80"
    exit 1
fi

if [ -z "$CHECK_FREQUENCY" ]
  then
    echo "CHECK_FREQUENCY is empty, exiting"
    exit 1
fi

echo "Waiting for $1:$2..."
until nc -z "$1" "$2"; do sleep "$CHECK_FREQUENCY"; done
echo "OK"