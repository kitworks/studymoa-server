#!/bin/bash

# 4000 = blue
# 4001 = green

# EXIST_A=`docker-compose -p studymoa-server ps  | grep Up | grep '4000->4000'`
blue=`docker-compose -p studymoa-server ps  | grep Up | grep '4000->4000' | wc -l`
echo "$blue"

blue_app=`docker-compose -p studymoa-server ps  | grep Up | grep '4000->4000' | awk '{print $1}'`
if [ $blue -eq 1 ]; then
	echo "\$VALUE is 1"
    # docker-compose up -d 
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
    # docker-compose up -d 
fi
source .env
echo "이미지 빌드"
docker-compose build
# sleep 10
echo "start_app == $start_app down_app == $down_app"
docker-compose up -d $start_app
echo "아파치 리로드"
echo $CURRENT
# docker-compose exec -e CURRENT=${CURRENT} web bash
echo "s/$down_app/$start_app/g"
sed -i .back "s/$down_app/$start_app/g" ./studymoa_web/000-default.conf
# sed -i studymoa_web/000-default.conf `s/$down_app/$start_app/g` studymoa_web/000-default.conf
docker-compose exec -e CURRENT=${CURRENT} web service apache2 reload
# docker-compose exec -e CURRENT=${CURRENT} web service apache2 reload
# docker-compose exec -e CURRENT=${CURRENT} web service apache2 reload

docker stop $down_app > /dev/null
# sleep 10
# docker-compose up -d web
# cat config.txt
docker-compose ps