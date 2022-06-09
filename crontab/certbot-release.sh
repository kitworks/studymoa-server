#!/bin/bash
# 인증서 갱신
sudo certbot renew
# 인증서 만료일에 관계 없이 강제 인증서 갱신
# sudo certbot renew --force-renewal

# release 에서 staging으로 certbot 키파일 갱신 및 동기화
sudo rsync -av -e "ssh -i /home/ubuntu/.ssh/kw_ec2_studymoa.pem" /etc/letsencrypt ubuntu@stg.studymoa.me:/tmp
# 웹서버 재기동
docker compose exec -d web service apache2 reload
# 인증서 확인
sudo certbot certificates