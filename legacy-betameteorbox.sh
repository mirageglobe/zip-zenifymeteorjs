#!/usr/bin/env bash

# ----- include libraries

# this code manages meteor uploads and deployment 

# ----- Functions

mb_usage() { 
  echo "$ESNOTE Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; 
}

mb_checkapplication() {
  # checking application installation

  echo "$ESNOTE checking graphicsmagick installation"
  command -v gm >/dev/null 2>&1 || { echo "$ESST graphicsmagick not installed [abort]" >&2; exit 1; }
  echo "$ESST [ok]"
}

mb_checkdirectory() {
  echo "$ESST [ok]"
}

mb_checkfile() {
  # checking destination of file 

  echo "$ESNOTE checking graphics file $1"
  if [ ! -f $1 ]; then
    echo "$ESST file not found [abort]"
    exit 1
  else
    echo "$ESST [ok]"
  fi
}


# ----- Variables

remote_ip="<remoteip>"   # this is your remote ip address
remote_user="<sshuser>"        # this should be your user
remote_root_folder="~"     # this should be your meteor app folder for example /home/usr/myname/myapp
local_project_name="<localprojectname>"

# ----- Main Code

echo "***"
echo "*** Running: Meteor Box ( $0 )"
echo "***"

while getopts ":s:p:" o; do
  case "${o}" in
    s)
      s=${OPTARG}
      ((s == 45 || s == 90)) || usage
      ;;
    p)
      p=${OPTARG}
      ;;
    *)
      usage
      ;;
  esac
done

shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ]; then
  mb_usage
fi

echo "s = ${s}"
echo "p = ${p}"

#meteor build . &
echo -n "[+] Building app ..."
#spinner $!
echo " DONE"

echo "[+] Pushing app to remote via SCP"
#scp $local_project_name.tar.gz $remote_user@$remote_ip:~
echo "... DONE"
#rm $local_project_name.tar.gz

echo "[+] Starting SSH ..."
#ssh $remote_user@$remote_ip

# ref http://www.shellhacks.com/en/Running-Commands-on-a-Remote-Linux-Server-over-SSH
