
TODO: 링크걸기 내부경로
dockerfile.admin
dockerfile.api 

ubuntu@ip-172-31-24-106:~/studymoa-server$ ln Dockerfile.web ./studymoa_web/Dockerfile.web
ubuntu@ip-172-31-24-106:~/studymoa-server$ ln Dockerfile.api ./studymoa_api/Dockerfile.api

## Setup

### docker 설치 

```
curl -s https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
```

```
ubuntu@ip-172-31-14-93:~$ docker -v
Docker version 20.10.16, build aa7e414
```

### docker login 시 에러

```
~$ docker login repository.com
** Message: 01:40:19.095: Remote error from secret service: org.freedesktop.DBus.Error.UnknownMethod:....
Error saving credentials: error storing credentials - err: exit status 1, out: `No such interface 'org.freedesktop.Secret.Collection' on object....
```

```
sudo apt-get install gnupg2 pass -y
```

### docker-compose 설치

```
$ DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
$ mkdir -p $DOCKER_CONFIG/cli-plugins
$ curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
$ chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
```

```
ubuntu@ip-172-31-14-93:~/studymoa-server$ docker compose version
Docker Compose version v2.5.0
```
## 인증서 발급 certbot

https://blog.wsgvet.com/letsencrypt-wildcard-certification-issue-and-mariadb-install/
```
sudo certbot certonly --manual --preferred-challenges=dns --email youremail@email.com --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d yourdomain.com -d *.yourdomian.com
```

```
ubuntu@ip-172-31-24-106:~$ sudo certbot certonly --manual --preferred-challenges=dns --email youremail@email.com --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d studymoa.me -d *.studymoa.me
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Requesting a certificate for studymoa.me and *.studymoa.me

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please deploy a DNS TXT record under the name:

_acme-challenge.studymoa.me.

with the following value:

loZnrHPe7MHFx8H-L87YO49Hjh_crkXcCcvnGS0q9VU

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Press Enter to Continue

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/studymoa.me/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/studymoa.me/privkey.pem
This certificate expires on 2022-08-23.
These files will be updated when the certificate renews.

NEXT STEPS:
- This certificate will not be renewed automatically. Autorenewal of --manual certificates requires the use of an authentication hook script (--manual-auth-hook) but one was not provided. To renew this certificate, repeat this same certbot command before the certificate's expiry date.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

## 인증서 갱신 

https://devlog.jwgo.kr/2019/04/16/how-to-lets-encrypt-ssl-renew/

```
$ certbot renew --dry-run
```

## github action && code deploy

### code deploy 로그 조회

```
tail -f /var/log/aws/codedeploy-agent/codedeploy-agent.log
```