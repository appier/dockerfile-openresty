FROM ubuntu:14.04
MAINTAINER ChangZhuo Chen (陳昌倬) <czchen@appier.com>

ENV WORKDIR=/srv

ADD . ${WORKDIR}

RUN dpkg -i ${WORKDIR}/packages/*.deb
RUN sed -i '1s/^/daemon off;\n/' /usr/local/openresty/nginx/conf/nginx.conf

RUN apt-get update && \
    apt-get install -qq supervisor && \
    apt-get clean

EXPOSE 80

VOLUME /srv/nginx/log
VOLUME /srv/nginx/error_log

CMD /usr/bin/supervisord -c ${WORKDIR}/supervisor/supervisord.conf
