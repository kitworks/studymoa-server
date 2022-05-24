#!/bin/bash

# 4000 = blue
# 4001 = green

# EXIST_A=`docker-compose -p studymoa-server ps  | grep Up | grep '4000->4000'`
blue=`docker-compose -p studymoa-server ps  | grep Up | grep '4000->4000' | wc -l`
echo "$blue"

blue_app=`docker-compose -p studymoa-server ps  | grep Up | grep '4000->4000' | awk '{print $1}'`
if [ $blue -eq 1 ]; then
	echo "\$VALUE is 1"
    start_app="green"
    down_app="blue"
    echo "2" > config.txt
    echo "CURRENT=green" > .env
else
	echo "\$VALUE is 2"
    start_app="blue"
    down_app="green"
    echo "1" > config.txt
    echo "CURRENT=blue" > .env
fi
source .env
echo "이미지 빌드"
docker-compose build
# sleep 10
echo "start_app == $start_app down_app == $down_app"
echo "s/$down_app/$start_app/g"
sed -i .back "s/$down_app/$start_app/g" ./studymoa_web/000-default.conf
is_run_web=`docker-compose -p studymoa-server ps  | grep Up | grep 'web' | wc -l`
if [ $is_run_web -eq 1 ]; then
    docker-compose up -d $start_app
    docker-compose exec -e CURRENT=${CURRENT} web service apache2 reload
else 
    docker-compose up -d web $start_app
fi

docker stop $down_app > /dev/null
# sleep 10
# docker-compose up -d web
docker-compose ps