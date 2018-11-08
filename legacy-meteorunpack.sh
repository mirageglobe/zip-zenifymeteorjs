#!/usr/bin/env bash

if [ ! -d bundle ]; then
  echo "[!] Could not find meteor bundle directory: /bundle"
  exit 0
fi

echo "[+] Backing up bundle"

name=bundlebackup$(date +"%Y%m%d")
tarfile=$name.tar.gz
while [ -f "$tarfile" ]
do
  n=$(( ${n:=0} + 1 ))
  tarfile=$name-$n.tar.gz
done

tar -zcf "$tarfile" bundle
echo "...done backed up as $tarfile"

echo "[+] Hot swapping bundle to bundlebackup"
if [ -d "bundlebackup" ]
	then
	rm -r bundlebackup
fi

mv bundle bundlebackup

echo "[+] Uncompressing meteor tar.gz"
tar -zxf adc.tar.gz

echo "[+] Removing meteor tar.gz"
rm adc.tar.gz

echo "[+] Removing forever process 0"
forever stop 0

echo "[+] Rerun Meteor start using startmet.sh"
./startmet.sh bundle

# look at methadone or gli
# and look at post http://stackoverflow.com/questions/897630/really-cheap-command-line-option-parsing-in-ruby
