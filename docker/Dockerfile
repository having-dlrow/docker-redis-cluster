# Use a temporary stage to pull the Bitnami image and extract scripts
FROM docker.io/bitnami/redis-cluster:7.0.12-debian-11-r13 AS bitnami
WORKDIR /opt/bitnami/scripts
COPY /opt/bitnami/scripts/ /opt/bitnami/scripts/

# Use the official RedisShake image as a base
FROM alpine:3.14

# Set variables for kubectl and RedisShake versions
ENV KUBECTL_VERSION="latest"
ENV REDIS_SHAKE_VERSION="2.0.1"

# Install required dependencies
RUN apk add --no-cache curl vim unzip jq restic redis

# Install RedisShake
RUN curl -LO "https://github.com/alibaba/RedisShake/releases/download/release-${REDIS_SHAKE_VERSION}/redis-shake-linux-amd64" && \
    chmod +x redis-shake-linux-amd64 && \
    mv redis-shake-linux-amd64 /usr/local/bin/redis-shake

WORKDIR /backup

# Copy necessary files
COPY s3 /backup/s3
COPY backup.bash env_vars.env /backup/

# Set the entrypoint to keep the container running
ENTRYPOINT ["tail", "-f", "/dev/null"]