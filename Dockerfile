FROM jasongwartz/alpine-perl:5.26.1-arm


RUN apk update && \
    apk add openssl openssl-dev && \
    adduser -S perl && \
    mkdir /home/perl/.ssh
RUN cpanm LWP::UserAgent LWP::Simple JSON LWP::Protocol::https

COPY github-ssh-keys.pl /github-ssh-keys.pl

USER perl

CMD ["perl", "/github-ssh-keys.pl"]
