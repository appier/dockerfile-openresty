FROM ubuntu:14.04
MAINTAINER ChangZhuo Chen (陳昌倬) <czchen@appier.com>

ENV WORKDIR=/srv

ADD . ${WORKDIR}

RUN dpkg -i ${WORKDIR}/packages/*.deb
RUN sed -i '1s/^/daemon off;\npid /var/run/openresty.pid;\n/' /usr/local/openresty/nginx/conf/nginx.conf

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq
        cron \
        logrotate \
        supervisor \
    && apt-get clean

EXPOSE 80

CMD /usr/bin/supervisord -c ${WORKDIR}/supervisor/supervisord.conf
