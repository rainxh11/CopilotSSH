FROM node:lts-alpine

# Install OpenSSH and dependencies
RUN apk add --no-cache openssh-server openssh-client \
    && mkdir -p /var/run/sshd \
    && ssh-keygen -A

# Configure SSH
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# Set default root password
ARG ROOT_PASSWORD=rootpassword
RUN echo "root:${ROOT_PASSWORD}" | chpasswd

WORKDIR /workdir

# Install GitHub Copilot CLI
RUN npm i -g @github/copilot@latest

# Expose SSH port
EXPOSE 22

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Start SSH server and keep container running
ENTRYPOINT ["copilot","--allow-all-tools"]
    
