# For x86: jasongwartz/alpine-perl:5.26.1-x86
# For arm: jasongwartz/alpine-perl:5.26.1-arm
FROM jasongwartz/alpine-perl:5.26.1-x86


RUN apk update && \
    apk add openssl openssl-dev && \
    cpanm LWP::UserAgent LWP::Simple JSON LWP::Protocol::https

RUN adduser -S perl

COPY github-ssh-keys.pl github-ssh-keys.pl
USER perl

CMD ["perl", "github-ssh-keys.pl"]
