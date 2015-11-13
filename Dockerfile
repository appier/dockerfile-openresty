FROM ubuntu:14.04

ENV WORKDIR=/srv

ADD . ${WORKDIR}

RUN dpkg -i ${WORKDIR}/packages/*.deb

RUN apt-get update && \
    apt-get install -qq supervisor && \
    apt-get clean

EXPOSE 80

VOLUME /srv/nginx/log
VOLUME /srv/nginx/error_log

CMD /usr/bin/supervisord -c ${WORKDIR}/supervisor/supervisord.conf
