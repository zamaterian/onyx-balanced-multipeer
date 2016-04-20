FROM anapsix/alpine-java:jre8

MAINTAINER David Flygenring Nielsen <david@graveyard.dk>




WORKDIR /
VOLUME ["/logs"]
ARG BUILD_NO
ARG SERVICE_NAME

LABEL microservice=$SERVICE_NAME
LABEL build_no=$BUILD_NO
LABEL app=batch_vur

EXPOSE 40201/udp
ENV APP_NAME=$SERVICE_NAME

ADD target/*-standalone.jar /

ADD start-app.sh /
# RUN mount -t tmpfs -o remount,rw,nosuid,nodev,noexec,relatime,size=256M tmpfs /dev/shm
ENTRYPOINT ["/start-app.sh"]
