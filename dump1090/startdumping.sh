#!/bin/bash

/bin/sed "s/sensor=false/key=$DUMP_GMAP_KEY\&sensor=false/g" gmap.html.orig > public_html/gmap.html
./dump1090 --net-http-port $DUMP_HTTP_PORT --net --net-sbs-port $DUMP_SBS_PORT --interactive --lat $DUMP_LAT --lon $DUMP_LON
