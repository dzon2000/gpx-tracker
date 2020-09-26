#!/bin/zsh
#awk '/time/, /time/ {print substr($1, 7, 19)}' tracks/29-Aug-2020-1742.gpx

TIME=`awk '/time/, /time/ {print substr($1, 7, 19)}' $1 | \
	((date --date $(head -n1) +%s) ; \
	(date --date $(tail -n1) +%s)) | \
	awk 'NR > 1 { print $0 - prev } { prev = $0 }'`

echo "var dur=$TIME;" > data.js 

DATA=`awk 'match($0, /lat=["0-9\.]+ lon=["0-9\.]+/) {split(substr($0, RSTART, RLENGTH),a,"\""); print "[",a[2],",",a[4],"],"}' $1`

echo "var latlngs=[${DATA%?}];" >> data.js
