# Dockerfile for Consul.
FROM alpine:3.3
MAINTAINER Tim Tosi "timothee.tosi@gmail.com"

# Install Consul.
RUN apk update \
    && apk add ca-certificates wget \
    && update-ca-certificates \
    && apk add --no-cache wget \
    && wget --progress=bar:force https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip \
    && unzip consul_0.6.4_linux_amd64.zip \
    && rm consul_0.6.4_linux_amd64.zip \
    && mv consul /usr/local/bin/

# Configure Consul environment.
RUN adduser -H -h /var/consul -S -D consul \
    && mkdir -p /var/consul \
    && addgroup consul \
    && chown -R consul:consul /var/consul \
    && mkdir -p /etc/consul.d/ \
    && chown -R root:consul /etc/consul.d

# Expose Consul ports.
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 53/udp

# Container entry point.
ENTRYPOINT [ "/usr/local/bin/consul", "agent" ]

# Entry point arguments.
# NOTE: Override CMD instruction for slave containers.
CMD [ "-dev", \
    "-server", \
    "-data-dir=/tmp", \
    "-log-level=info", \
    "-client=0.0.0.0", \
    "-ui" ]
