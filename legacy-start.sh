#!/bin/bash

echo "[+] Starting Meteor App!"
if [ "$1" = "" ]
        then
        echo "[-] Usage: <dir>"
        echo "[!] Path needed for the containing project folder"
        exit 0
fi
if [ ! -d $1 ]
        then
        echo "[!] Could not enter the dir: $1"
        exit 0
fi
cd $1
echo "[+] Running NPM"
npm install &>/dev/null
echo "[+] Setting environment variables"
export MONGO_URL='mongodb://<user>:<password>@localhost/<tablename>'
export PORT=8888
export ROOT_URL='http://localhost/'
echo "[+] Starting Node Server"

forever start main.js
