#!/bin/bash
# release 에서 받은 인증서 파일, 실제 /etc에 적용
sudo rsync -az --progress /tmp/letsencrypt /etc
# 웹서버 재기동
docker compose exec -d web service apache2 reload
# 인증서 확인
sudo certbot certificates