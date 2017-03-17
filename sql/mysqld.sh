#!/bin/sh

# Define default mysql socket value and try to retrieve value from arguments.
MYSQL_SOCKET="--socket=/var/run/mysqld/mysqld.sock"
for arg in "$@"; do
	case "$arg" in
		--socket=*) MYSQL_SOCKET=$arg ;;
	esac
done

# Bring mysqld to background.
/usr/bin/mysqld $@ &
sleep 10s

# Running scripts intended to populate the database.
echo
for f in /initdb/*; do
	case "$f" in
		*.sh)  echo "$0: running $f"; . "$f" "$@";;
		*.sql) echo "$0: running $f"; mysql $MYSQL_SOCKET < "$f" && echo ;;
		*)     echo "$0: ignoring $f" ;;
	esac
	echo
done

# Advertise as ready.
echo "Listening to :9090"
while true ; do echo "ready" | nc -l 0.0.0.0 9090 ; done
echo "Test probe received."

# Nohup without nohup.
tail -f /dev/null
