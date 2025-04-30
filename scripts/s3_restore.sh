#!/bin/bash

if [ -n "$S3_BUCKET" ]; then
  echo "Restoring Jenkins data from S3..."
  aws s3 sync s3://$S3_BUCKET/jenkins_home /var/jenkins_home || echo "S3 sync failed"
fi
