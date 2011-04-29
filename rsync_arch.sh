#!/bin/bash

#################################################################################################
### It is generally frowned upon to create a local mirror due the bandwidth that is required.
### One of the alternatives will likely fulfill your needs.
### REMEMBER:
###   * Bandwidth is not free for the mirrors. They must pay for all the data they serve you
###       => This still applies although you pay your ISP 
###       => There are many packages that will be downloaded that you will likely never use
###       => Mirror operators will much prefer you to download only the packages you need
###   * Really please look at the alternatives on this page:
###       http://wiki.archlinux.org/index.php?title=Local_Mirror
### If you are ABSOLUTELY CERTAIN that a local mirror is the only sensible solution, then this
### script will get you on your way to creating it. 
#################################################################################################

# Configuration
SOURCE='rsync://ftp5.gwdg.de/pub/linux/archlinux'
DEST='/media/Diverse/ftp/mirror/archlinux'
BW_LIMIT='500'
LOGFILE='/var/log/rsync.log'
REPOS='core extra community'
# deleted option --max-delete=1000
RSYNC_OPTS="-rtlH --verbose --delete-after --log-file=${LOGFILE} --delay-updates --copy-links --safe-links --bwlimit=${BW_LIMIT} --delete-excluded --exclude=.*"
LCK_FLE='/home/rootman/repo-sync.lck'

# Make sure only 1 instance runs
if [ -e "$LCK_FLE" ] ; then
	OTHER_PID=`/bin/cat $LCK_FLE`
	echo "Another instance already running: $OTHER_PID"
	exit 1
fi
echo $$ > "$LCK_FLE"

for REPO in $REPOS ; do
	echo "Syncing $REPO"
	echo /usr/bin/rsync $RSYNC_OPTS ${SOURCE}/${REPO} ${DEST}
	/usr/bin/rsync $RSYNC_OPTS ${SOURCE}/${REPO} ${DEST}
done

# Cleanup
/bin/rm -f "$LCK_FLE"

exit 0

