FROM alpine:latest

RUN apk add rtpengine curl

COPY ./entrypoint.sh /entrypoint.sh
COPY ./rtpengine.conf /etc
ENTRYPOINT ["/entrypoint.sh"]
CMD ["rtpengine"]

HEALTHCHECK CMD curl --fail http://localhost:8080/ping || exit 1
