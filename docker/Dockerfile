# Use a temporary stage to pull the Bitnami image and extract scripts
FROM docker.io/bitnami/redis-cluster:7.0.12-debian-11-r13 AS bitnami

# Create your final image
FROM alpine:3.14

# Copy the scripts from the temporary stage
COPY --from=bitnami /opt/bitnami /opt/bitnami
RUN chmod g+rwX /opt/bitnami

# Install required dependencies
RUN apk add --no-cache curl unzip jq restic redis

# Set variables for kubectl and RedisShake versions
ENV KUBECTL_VERSION="latest"
ENV REDIS_SHAKE_VERSION="2.0.1"

# Install RedisShake
RUN curl -LO "https://github.com/alibaba/RedisShake/releases/download/release-${REDIS_SHAKE_VERSION}/redis-shake-linux-amd64" && \
    chmod +x redis-shake-linux-amd64 && \
    mv redis-shake-linux-amd64 /usr/local/bin/redis-shake

WORKDIR /backup

# Copy necessary files
COPY s3 /backup/s3
COPY backup.bash env_vars.env /backup/