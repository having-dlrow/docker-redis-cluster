# Use the official RedisShake image as a base
FROM alpine:3.14

# Set variables for kubectl and RedisShake versions
ENV KUBECTL_VERSION="latest"
ENV REDIS_SHAKE_VERSION="2.0.1"

# Install required dependencies
RUN apk add --no-cache curl vim unzip jq restic redis

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/stable.txt" && \
    curl -LO "https://dl.k8s.io/$(cat stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Install RedisShake
RUN curl -LO "https://github.com/alibaba/RedisShake/releases/download/release-${REDIS_SHAKE_VERSION}/redis-shake-linux-amd64" && \
    chmod +x redis-shake-linux-amd64 && \
    mv redis-shake-linux-amd64 /usr/local/bin/redis-shake

# Set working directory
WORKDIR /backup

# Copy necessary files
COPY backup-user.bash env_vars.env /backup/

# Set the entrypoint to keep the container running
ENTRYPOINT ["tail", "-f", "/dev/null"]