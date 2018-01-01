FROM scottw/alpine-perl:5.26.1

RUN apk update && apk add openssl openssl-dev
RUN cpanm LWP::UserAgent LWP::Simple JSON LWP::Protocol::https
RUN echo "* * * * * perl /github-ssh-keys.pl" > /etc/crontabs/root

COPY github-ssh-keys.pl /github-ssh-keys.pl

CMD ["crond", "-f"]
