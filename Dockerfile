FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y awscli && rm -rf /var/lib/apt/lists/*

USER jenkins

# S3 restore script
COPY s3_restore.sh /usr/local/bin/s3_restore.sh
COPY s3_backup.sh /usr/local/bin/s3_backup.sh
RUN chmod +x /usr/local/bin/s3_*.sh

ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/s3_restore.sh && /usr/bin/tini -- /usr/local/bin/jenkins.sh"]
