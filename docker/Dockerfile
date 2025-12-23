FROM jenkins/jenkins:lts-jdk17

USER root

# Install AWS CLI + essentials
RUN apt-get update && \
    apt-get install -y \
      awscli \
      curl \
      unzip && \
    apt-get clean

# Jenkins home
ENV JENKINS_HOME=/var/jenkins_home

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER jenkins

ENTRYPOINT ["/entrypoint.sh"]
