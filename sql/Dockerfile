# Dockerfile for mysql test database.
FROM alpine:3.3
MAINTAINER Tim Tosi "timothee.tosi@gmail.com"

# Copy start-up script.
COPY mysqld.sh /usr/bin/mysqld.sh

# Create a mounting point for data volume.
# NOTE: If you want to populate the database with your own scripts when running
# the image, use the argument `-v /path/to/your/scripts:/initdb`.
RUN mkdir /initdb

# Install MySQL.
RUN apk update \
    && apk add mysql \
    && apk add mysql-client \
    && apk add --update netcat-openbsd \
    && rm -f /var/cache/apk/* \
    && rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql \
    && mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql \
    && chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld \
    && mysql_install_db --user=mysql --datadir=/var/lib/mysql/ > /dev/null \
    && chmod +x /usr/bin/mysqld.sh


# Expose server ports.
EXPOSE 3306 9090

# Container entry point.
ENTRYPOINT [ "/usr/bin/mysqld.sh" ]

# Entry point arguments.
# NOTE: Override CMD instruction for custom options.
# NOTE : `--bind-address` should be configured using `0.0.0.0`.
CMD [ "--basedir=/usr", \
    "--bind-address=0.0.0.0", \
    "--concurrent_insert=2", \
    "--datadir=/var/lib/mysql", \
    "--join_buffer_size=2M", \
    "--key_buffer_size=128M", \
    "--low-priority-updates=1", \    
    "--max_allowed_packet=16M", \
    "--max_connections=400", \
    "--max_heap_table_size=256M", \
    "--myisam_sort_buffer_size=64M", \
    "--pid-file=/var/run/mysqld/mysqld.pid", \
    "--port=3306", \
    "--query_cache_limit=1M", \
    "--query_cache_size=16M", \    
    "--read_buffer_size=1024K", \
    "--read_rnd_buffer_size=4096K", \
    "--skip-grant-tables", \    
    "--socket=/var/run/mysqld/mysqld.sock", \
    "--sort_buffer_size=1024K", \
    "--thread_cache_size=8", \
    "--thread_stack=128K", \
    "--tmpdir=/tmp", \
    "--tmp_table_size=512M", \
    "--transaction-isolation=READ-COMMITTED", \
    "--user=mysql", \
    "--wait_timeout=60" ]
