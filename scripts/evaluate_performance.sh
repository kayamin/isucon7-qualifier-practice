#!/bin/bash

set -e
sudo systemctl restart isubata.golang.service
sleep 5
echo | sudo tee /var/log/nginx/access.ltsv
echo | sudo tee /var/log/mysql/mysql-slow.log

cd ../bench
sudo ./bin/bench -remotes localhost:80

cat /var/log/nginx/access.ltsv | alp ltsv --sort avg -r -m "/history/[0-9a-zA-Z]+","/icons/*.","/profile/*.","/channel/*."
