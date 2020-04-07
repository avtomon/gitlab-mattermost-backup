#!/bin/bash

currDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
confFile="$currDir/backup_mattermost.conf"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# conffile
if [ -e $confFile -a -r $confFile ]
then
    source $confFile
else
    echo "$confFile not found."
    exit 1
fi

echo "mattermostDir = $mattermostDir"
echo "localBackupDir = $localBackupDir"
echo "remoteBackupDir = $remoteBackupDir"
echo "sshHost = $sshHost"
echo "sshPort = $sshPort"
echo "sshUser = $sshUser"
echo "sshKeyPath = $sshPassphrase" 
echo "sshPassphrase = $sshPassphrase"

# prepare
#rm -rf $localBackupDir
mkdir -p $localBackupDir
mkdir -p $localBackupDir/data
mkdir -p $localBackupDir/postgresql

# backup data
cp -R $mattermostDir/data/* $localBackupDir/data/
# backup postgres
pg_dump -U postgres -h /var/run/postgresql/ -p 5432 mattermost | gzip > $localBackupDir/postgresql/$(date +\%Y-\%m-\%d_\%H:\%M:\%S)_dump.gz

# upload to backup server
sshpass -P 'passphrase' -p "$sshPassphrase" rsync -avz -e "ssh -i $sshKeyPath -p $sshPort" "$localBackupDir/" "$sshUser@$sshHost:$remoteBackupDir/"
