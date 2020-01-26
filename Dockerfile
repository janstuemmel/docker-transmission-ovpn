FROM alpine

ENV PS1="\u@\w\$ "

RUN addgroup app && adduser -h /app -S -u 1000 -s /bin/bash app -G app

RUN apk --no-cache add bash curl vim openvpn transmission-daemon

ADD entrypoint.sh updown.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

RUN mkdir /ovpn /downloads /transmission \
  && chown app.app -R /downloads /transmission

EXPOSE 9091

VOLUME /transmission /downloads

WORKDIR /ovpn

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]