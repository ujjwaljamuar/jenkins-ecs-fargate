#!/bin/bash

if [ -n "$S3_BUCKET" ]; then
  echo "Backing up Jenkins data to S3..."
  aws s3 sync /var/jenkins_home s3://$S3_BUCKET/jenkins_home || echo "S3 backup failed"
fi
