FROM postgres:13-alpine

USER root

ENV HIVE_VERSION 2.3.9

RUN export LANGUAGE=en_US.UTF-8
COPY configs/hive-schema-$HIVE_VERSION.postgres.sql /hive/hive-schema-$HIVE_VERSION.postgres.sql
COPY configs/hive-txn-schema-$HIVE_VERSION.postgres.sql /hive/hive-txn-schema-$HIVE_VERSION.postgres.sql

COPY configs/init-hive-db.sh /docker-entrypoint-initdb.d/init-user-db.sh

# open port 22
RUN mkdir -p /run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"] 