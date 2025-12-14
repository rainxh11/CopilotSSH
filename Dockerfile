FROM linuxserver/openssh-server:latest
# Install Node.js and GitHub Copilot CLI
RUN apk add --no-cache nodejs npm && \
    npm i -g @github/copilot@latest
#ENTRYPOINT [ "copilot","--allow-all-tools" ]
ENTRYPOINT [ "/bin/sh" ]