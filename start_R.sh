#!/bin/bash
docker run --rm  -d -p 9999:9999 -v /home/osboxes/R-SHARED:/R-SHARED --name r-upm-masters markw/r-upm-masters:latest
sleep 2
firefox http://localhost:9999
