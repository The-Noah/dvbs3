#!/bin/sh

set -e

if [ -z "$1" ]; then
  echo "Missing volume name"
  exit 1
elif [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "Missing AWS_ACCESS_KEY_ID"
  exit 1
elif [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "Missing AWS_SECRET_ACCESS_KEY"
  exit 1
fi

if [ ! -z "$S3_PROVIDER" ]; then
  echo "Using S3 provider: $S3_PROVIDER"

  if [ "$S3_PROVIDER" = "aws" ]; then
    S3_HOST="s3.amazonaws.com"
    S3_HOST_BUCKET="%(bucket)s.s3.amazonaws.com"
  elif [ "$S3_PROVIDER" = "vultr" ]; then
    S3_HOST="ewr1.vultrobjects.com"
    S3_HOST_BUCKET="%(bucket)s.ewr1.vultrobjects.com"
  else
    echo "Unknown S3 provider: $S3_PROVIDER"
    exit 1
  fi

  echo "Using S3_PROVIDER: $S3_PROVIDER"
fi

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Starting backup of volume $1..."

filename="$1-$(date +"%Y-%m-%d").tar.gz"

docker run --rm \
  -v $1:/backup-volume:ro \
  busybox \
  sh -c "ls -A -1 /backup-volume | tar -cOzf - -C /backup-volume -T -" > /tmp/$filename

s3cmd put --host=$S3_HOST --host-bucket=$S3_HOST_BUCKET /tmp/$filename s3://$S3_BUCKET/$(date +"%Y")/$(date +"%m")/$filename || exit 2

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Done!"
