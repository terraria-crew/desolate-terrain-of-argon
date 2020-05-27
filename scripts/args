#!/bin/bash

OPTS=`getopt -o h -l help -l tml -l iid: -l password: -l port: -l world-name: -- "$@"`
if [ $? != 0 ]
then
    exit 1
fi

function usage() {
  echo ""
  echo "Usage:"
  echo ""
  echo "  $0 --iid <Instance ID> [OPTIONS]"
  echo "  --tml: Enable tModLoader"
  echo "  --password: Set server password"
  echo "  --port: Set server port"
  echo "  --world-name: Set the desired world name to be loaded or created."
  echo ""
}

eval set -- "$OPTS"

while true ; do
    case "$1" in
        -h) usage; exit;;
        --help) usage; exit;;
        --iid) iid=$2; shift 2;;
        --password) password=$2; shift 2;;
        --port) port=$2; shift 2;;
        --world-name) world_name=$2; shift 2;;
        --tml) tml_enabled=true; shift;;
        --) shift; break;;
    esac
done

if [ ! "$iid" ]; then
  echo "No instance ID parameter supplied (--iid).";
  usage;
  exit 1
fi
if [ ! "$tml_enabled" ]; then
  tml_enabled=false
fi
