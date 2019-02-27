FROM factominc/factomd:v6.1.1-rc1-alpine

WORKDIR /home/factomd

RUN set -xe && \
  apk add --no-cache gettext inotify-tools shadow && \
  groupadd -g 1000 factomd && \
  useradd -r -m -u 1000 -g factomd factomd && \
  mv /root/.factom . && \
  mkdir -p .factom/private .factom/private-conv && \
  touch .factom/private/factomd.conf && \
  chown -R factomd:factomd .

COPY ./entrypoint.sh /home/factomd/

VOLUME /home/factomd/.factom/m2

VOLUME /home/factomd/.factom/private

USER factomd

ENV LOCAL_SERVER_PRIVATE_KEY ""

ENTRYPOINT ["./entrypoint.sh", "-config=/home/factomd/.factom/private-conv/factomd.conf"]
