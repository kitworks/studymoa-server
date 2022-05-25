#!/bin/bash

WORKDIR=/home/ubuntu/studymoa-server
cd $WORKDIR
# 4000 = blue
# 4001 = green

log () {
  echo -e "[LOG]" "\033[32;1m"`date "+%Y-%m-%d %H:%M:%s"`"\033[0m" "\033[33;1m"$1"\033[0m"
}

blue=`docker-compose -p studymoa-server ps  | grep '4000->4000' | wc -l`
# blue=`docker-compose -p studymoa-server ps  | grep Up | grep '4000->4000' | wc -l`
if [ $blue -eq 1 ]; then
    start_app="green"
    down_app="blue"
    echo "CURRENT=green" > .env
else
    start_app="blue"
    down_app="green"
    echo "CURRENT=blue" > .env
fi
source .env
log "이미지 빌드"
docker-compose build
# sleep 10
log "start_app == $start_app down_app == $down_app"
log "아파치 프록시 $down_app->$start_app 변경"

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     sed -i "s/$down_app/$start_app/g" ./studymoa_web/sites-available/000-default.conf;;
    Darwin*)    sed -i .back "s/$down_app/$start_app/g" ./studymoa_web/sites-available/000-default.conf;;
    *)          exit 1
esac

# is_run_web=`docker-compose -p studymoa-server ps  | grep Up | grep 'web' | wc -l`
is_run_web=`docker-compose -p studymoa-server ps | grep 'web' | wc -l`
log "아파치 컨테이너 체크 == $is_run_web"
if [ $is_run_web -eq 1 ]; then
    docker-compose up -d $start_app
    # sleep 10
    # docker-compose exec -e CURRENT=${CURRENT} sed -i "s/$down_app/$start_app/g" ./studymoa_web/000-default.conf
    docker-compose exec -d -e CURRENT=${CURRENT} web service apache2 reload
    log "아파치 리로드"
else 
    docker-compose up -d web $start_app
    log "아파치 및 $start_app 실행"
fi

docker stop $down_app > /dev/null
# sleep 10
# docker-compose up -d web
docker-compose ps