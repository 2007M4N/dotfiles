#!/bin/bash
#################################################################################################
### This is a generaly sample backup script 
#################################################################################################




# Configuration
SOURCE='domian.ltd:XXX'
DEST='PATH'
BW_LIMIT='500' #SPEEDLIMIT
LOGFILE='/var/log/rsync.log' #CHECK PERMISSIONS AND CREATE FILE FIRST
ADD='::public'
FOLDERS="PATH"
REPOS='arm i686 x86_64'
RSYNC_OPTS="-auvz --delete-after --log-file=${LOGFILE} --delay-updates --safe-links --max-delete=1000 --bwlimit=${BW_LIMIT} --delete-excluded --exclude=.*"
LCK_FLE='PATH/rsyncbck.lck'

# Make sure only 1 instance runs
if [ -e "$LCK_FLE" ] ; then
	OTHER_PID=`/bin/cat $LCK_FLE`
	echo "Another instance already running: $OTHER_PID"
	exit 1
fi
echo $$ > "$LCK_FLE"

 for REPO in $FOLDERS ; do
	 echo "Syncing $FOLDERS"
	 echo /usr/bin/rsync $RSYNC_OPTS ${SOURCE}/${FOLDERS} ${DEST}
	 /usr/bin/rsync $RSYNC_OPTS ${SOURCE}/${FOLDERS} ${DEST}
	  done

	  # Cleanup
	  /bin/rm -f "$LCK_FLE"

	  exit 0


