FROM gethue/hue:latest

USER root

COPY configs/hue.ini /usr/share/hue/desktop/conf/hue.ini
COPY configs/hue.ini /usr/share/hue/desktop/conf/hue-overrides.ini 
COPY configs/hue.ini /usr/share/hue/tools/docker/hue/conf/hue-overrides.ini
RUN mkdir -p /etc/hive/conf

# set environment variables
ENV HIVE_CONF_DIR /etc/hive/conf

COPY configs/hive-site.xml $HIVE_CONF_DIR/hive-site.xml
