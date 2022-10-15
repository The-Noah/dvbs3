FROM docker:latest

RUN apk add python3 --no-cache --no-scripts && \
  python3 -m ensurepip --upgrade && \
  pip3 install s3cmd --upgrade && \
  rm -rf /var/cache/apk

ADD run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
