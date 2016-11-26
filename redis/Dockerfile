# Dockerfile for redis-server.
FROM alpine:3.3
MAINTAINER Tim Tosi "timothee.tosi@gmail.com"

# Install build-essential equivalent & Install Redis.
RUN apk update \
    && apk add ca-certificates build-base \
    && update-ca-certificates \
    && apk add --no-cache build-base \
    && apk add ca-certificates 	linux-headers \
    && update-ca-certificates \
    && apk add --no-cache linux-headers \
    && apk add ca-certificates wget \
    && update-ca-certificates \
    && apk add --no-cache wget \
    && wget --progress=bar:force http://download.redis.io/redis-stable.tar.gz \
    && tar xfz redis-stable.tar.gz \
    && rm redis-stable.tar.gz \
    && cd redis-stable \
    && make \
    && make install \
    && cd .. \
    && rm -fr redis-stable \
    && apk del build-base linux-headers

# Configure Redis environment.
RUN mkdir -p /var/db/redis/ \
    && touch /etc/sentinel.conf

# Expose Redis server ports.
EXPOSE 6379 26379

# Container entry point.
ENTRYPOINT [ "/usr/local/bin/redis-server" ]

# Entry point arguments.
# NOTE: Override CMD instruction for slave and sentinel containers.
CMD [ \
    "--daemonize no", \
    "--port 6379", \
    "--bind 0.0.0.0", \
    "--timeout 0", \
    "--tcp-keepalive 0", \
    "--loglevel notice", \
    "--logfile stdout", \
    "--databases 16", \
    "--save ''", \
    "--stop-writes-on-bgsave-error yes", \
    "--rdbcompression yes", \
    "--rdbchecksum yes", \
    "--dbfilename dump.rdb", \
    "--dir /var/db/redis/", \
    "--slave-serve-stale-data yes", \
    "--slave-read-only yes", \
    "--repl-disable-tcp-nodelay no", \
    "--slave-priority 100", \
    "--appendonly no", \
    "--appendfsync no", \
    "--no-appendfsync-on-rewrite no", \
    "--auto-aof-rewrite-percentage 100", \
    "--auto-aof-rewrite-min-size 64mb", \
    "--lua-time-limit 5000", \
    "--slowlog-log-slower-than 10000", \
    "--slowlog-max-len 128", \
    "--hash-max-ziplist-entries 512", \
    "--hash-max-ziplist-value 64", \
    "--list-max-ziplist-entries 512", \
    "--list-max-ziplist-value 64", \
    "--set-max-intset-entries 512", \
    "--zset-max-ziplist-entries 128", \
    "--zset-max-ziplist-value 64", \
    "--activerehashing yes", \
    "--client-output-buffer-limit normal 0 0 0", \
    "--client-output-buffer-limit slave 256mb 64mb 60", \
    "--client-output-buffer-limit pubsub 32mb 8mb 60", \
]
