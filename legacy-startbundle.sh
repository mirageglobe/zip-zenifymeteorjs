#!/bin/bash

spinner(){
  PROC=$1
  while [ -d "/proc/$PROC" ];do
    echo -n '/^H' ; sleep 0.05
    echo -n '-^H' ; sleep 0.05
    echo -n '\^H' ; sleep 0.05
    echo -n '|^H' ; sleep 0.05
  done

  return 0
}

echo "[+] Starting Meteor App! without Demeteorizer"

if [ "$1" = "" ]
  then
    echo "[-] Usage: <dir>"
    echo "[!] Path needed for the containing project folder"
    exit 1
fi

if [ ! -d "$1" ]; then
  echo "[!] Could not enter the dir: $1"
  exit 1
fi

cd "$1" || exit 1

#echo "[+] Running NPM"
#npm install &>/dev/null
echo "[+] Running Bundle and Refresh Fibers"
#pushd $(pwd)/node_modules
#rm -r fibers
#rm -r underscore
#npm install fibers@1.0.1
#popd
pushd $(pwd)/programs/server || exit 1
rm -r node_modules
npm install
#npm install fibers@1.0.1
#npm install bcrypt
popd
pushd $(pwd)/programs/server/npm/npm-bcrypt/node_modules
rm -r bcrypt
popd
pushd $(pwd)/programs/server/npm/npm-bcrypt
npm install bcrypt
popd
echo "[+] Setting environment variables"
export MONGO_URL='mongodb://<user>:<password>@localhost/<tablename>'
export PORT=8888
export ROOT_URL='http://localhost/'
# export MAIL_URL='smtp://user:password@mailhost:port/'
# MAIL_URL=smtp://postmaster%40YOUR_DOMAIN.mailgun.org:YOUR_PASSWORD@smtp.mailgun.org:587/
echo "[+] Starting Node Server"

#node main.js
forever start main.js
