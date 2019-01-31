# Adapted from regueiro/calibre-server,
# but without exposing ports or the web server.
FROM ubuntu:17.10

RUN apt-get update -y \
&& apt-get install -y calibre \
&& apt-get clean \
&& rm -rf /var/cache/apt/* /var/lib/apt/lists/*

COPY download-and-send.sh /opt/download-and-send.sh

ENTRYPOINT ["/opt/download-and-send.sh"]
