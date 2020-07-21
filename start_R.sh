#!/bin/bash
docker run --rm -it -p 9999:9999 -v /home/osboxes/R-SHARED:/R-SHARED --name r-upm-masters r-upm-masters:latest
cd /home/osboxes/R-SHARED
firefox http://localhost:9999
