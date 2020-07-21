#!/bin/bash
docker run --rm -it -d -p 9999:9999 -v /home/osboxes/R-SHARED:/R-SHARED --name r-upm-masters markw/r-upm-masters:latest
cd /home/osboxes/R-SHARED
sleep 2
firefox http://localhost:9999
