#
# Regular cron jobs for the ttg2 package
#
0 4	* * *	root	[ -x /usr/bin/ttg2_maintenance ] && /usr/bin/ttg2_maintenance
