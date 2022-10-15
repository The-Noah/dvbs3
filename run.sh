#!/bin/sh

set -e

if [ -z "$1" ]; then
  echo "Missing volume name"
  exit 1
fi

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Starting backup of volume $1..."

filename="$1_$(date +"%Y%m%d").tar.gz"

docker run --rm \
  -v $1:/backup-volume:ro \
  busybox \
  tar -zcvf /tmp/$filename -C /backup-volume .

s3cmd put --host=$S3_HOST --host-bucket=$S3_HOST_BUCKET /tmp/$filename s3://$S3_BUCKET/$(date +"%Y")/$(date +"%m")/$filename || exit 2

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Done!"
