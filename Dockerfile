FROM jenkins/jenkins:2.361.2-lts-slim
USER root
RUN apt-get update && apt-get install -y \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg2 \
       software-properties-common \
       --no-install-recommends \
       && apt-get clean \
       && rm -rf /var/lib/apt/lists/*
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y \
       docker-ce-cli \
       --no-install-recommends\
       && apt-get clean \
       && rm -rf /var/lib/apt/lists/*
RUN curl -L "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-$(uname -s)-$(uname -m)" \
       -o /usr/local/bin/docker-compose  \
       && chmod +x /usr/local/bin/docker-compose \
       &&  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
USER jenkins
# Bypass broken mirror to download plugins
ENV JENKINS_UC_DOWNLOAD_URL=https://archives.jenkins.io/plugins/
RUN jenkins-plugin-cli --plugins blueocean:1.25.2
