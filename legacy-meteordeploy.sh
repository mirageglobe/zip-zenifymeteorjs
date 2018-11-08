#!/usr/bin/env bash

# should use #!/usr/bin/env bash for portability - http://stackoverflow.com/questions/10376206/preferred-bash-shebang

remote_ip="<yourremoteip>"   # this is your remote ip address
remote_user="<ssh user>"        # this should be your user
remote_root_folder="~"     # this should be your meteor app folder for example /home/usr/myname/myapp
local_project_name="<yourprojectname>"

spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
      local temp=${spinstr#?}
      printf " [%c]  " "$spinstr"
      local spinstr=$temp${spinstr%"$temp"}
      sleep $delay
      printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

echo "========================"
echo " Meteor - Uploading App"
echo "========================"

#exit 0

meteor build . &
echo -n "[+] Building app ..."
spinner $!
echo " DONE"

echo "[+] Pushing app to remote via SCP"
scp $local_project_name.tar.gz $remote_user@$remote_ip:~
echo "... DONE"
rm $local_project_name.tar.gz

echo "[+] Starting SSH ..."
ssh $remote_user@$remote_ip

# ref http://www.shellhacks.com/en/Running-Commands-on-a-Remote-Linux-Server-over-SSH
