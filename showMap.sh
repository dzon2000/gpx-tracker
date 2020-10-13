#!/bin/zsh

TIME=`awk '/time/, /time/ {print substr($1, 7, 19)}' $1`
echo "var time=[`echo $TIME | awk 'NR > 1 {printf ("%s",",")} {printf ("\\"%s\\"", $0)}'`]" > data.js
DURATION=`stdbuf -oL echo $TIME | \
	((date --date $(head -n1) +%s) && \
	(date --date $(tail -n1) +%s)) | \
	awk 'NR > 1 { print $0 - prev } { prev = $0 }'`

echo "var dur=$DURATION;" >> data.js 

DATA=`awk 'match($0, /lat=["0-9\.]+ lon=["0-9\.]+/) {split(substr($0, RSTART, RLENGTH),a,"\""); print "[",a[2],",",a[4],"],"}' $1`

echo "var latlngs=[${DATA%?}];" >> data.js
