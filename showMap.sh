#!/bin/zsh
#awk '/time/, /time/ {print substr($1, 7, 19)}' tracks/29-Aug-2020-1742.gpx
DATA=`awk 'match($0, /lat=["0-9\.]+ lon=["0-9\.]+/) {split(substr($0, RSTART, RLENGTH),a,"\""); print "[",a[2],",",a[4],"],"}' $1`

echo "var latlngs=[${DATA%?}];" > data.js
