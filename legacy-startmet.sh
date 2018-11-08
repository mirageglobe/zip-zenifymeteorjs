#!/bin/bash

echo "[+] Starting Meteor App! without Demeteorizer"
if [ "$1" = "" ]; then
  echo "[-] Usage: <dir>"
  echo "[!] Path needed for the containing project folder"
  exit 1
fi

if [ ! -d $1 ]; then
  echo "[!] Could not enter the dir: $1"
  exit 1
fi

cd $1

#echo "[+] Running NPM"
#npm install &>/dev/null

echo "[+] Running Bundle and Refresh Fibers"
pushd $(pwd)/node_modules
#pushd $(pwd)/programs/server/node_modules

rm -r fibers
npm install fibers@1.0.1
popd

echo "[+] Setting environment variables"
export MONGO_URL="mongodb://<user>:<password>@localhost/<tablename>"
export PORT="8888"
export ROOT_URL="http://localhost/"

# export MAIL_URL='smtp://user:password@mailhost:port/'
# MAIL_URL=smtp://postmaster%40YOUR_DOMAIN.mailgun.org:YOUR_PASSWORD@smtp.mailgun.org:587/
echo "[+] Starting Node Server"

forever start main.js
