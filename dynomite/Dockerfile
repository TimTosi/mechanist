# Dockerfile for Dynomite.
FROM ubuntu:xenial
MAINTAINER Tim Tosi "timothee.tosi@gmail.com"

# Install tooling, libraries & Dynomite.
RUN apt-get -y update \
	&& apt-get install -y autoconf build-essential dh-autoreconf git libssl-dev \
	&& git clone https://github.com/Netflix/dynomite.git \
	&& cd dynomite \
	&& autoreconf -fvi \
	&& ./configure --enable-debug=log \
	&& CFLAGS="-ggdb3 -O0" ./configure --enable-debug=full \
	&& make \
	&& make install \
	&& mkdir -p /etc/dynomitedb \
	&& cp conf/dynomite.pem /etc/dynomitedb/dynomite.pem \
	&& cd .. \
	&& rm -fr dynomite \
	&& apt-get remove --purge -y autoconf build-essential dh-autoreconf git $(apt-mark showauto | sed -e 's/libssl1.0.0//g') \
	&& rm -rf /var/lib/apt/lists/*

# Expose Dynomite server ports.
EXPOSE 8101 8102

# Container entry point.
ENTRYPOINT [ "dynomite" ]

# Entry point arguments.
# NOTE: Override CMD instruction for command line configuration.
CMD [ "-h" ]
