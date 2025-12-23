#!/bin/bash
set -e

echo "🔄 Jenkins container starting..."

if [ -z "$S3_BUCKET_JENKINS_ON_DEMAND" ]; then
  echo "❌ S3_BUCKET_JENKINS_ON_DEMAND env var not set"
  exit 1
fi

# Restore Jenkins home
if aws s3 ls "s3://$S3_BUCKET_JENKINS_ON_DEMAND/jenkins-home/" >/dev/null 2>&1; then
  echo "⬇️ Restoring Jenkins home from S3..."
  aws s3 sync s3://$S3_BUCKET_JENKINS_ON_DEMAND/jenkins-home $JENKINS_HOME
else
  echo "ℹ️ No existing Jenkins state found in S3"
fi

# Ensure correct ownership
chown -R jenkins:jenkins $JENKINS_HOME

echo "🚀 Starting Jenkins (PID 1)..."
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
