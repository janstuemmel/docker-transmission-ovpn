FROM alpine

ENV PS1="\u@\w\$ "

RUN addgroup app && adduser -h /app -S -u 1000 -s /bin/bash app -G app

RUN apk --no-cache add bash curl vim openvpn transmission-daemon

RUN apk --no-cache add dockerize --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

ADD entrypoint.sh updown.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

RUN mkdir /ovpn /downloads /transmission \
  && chown app.app -R /downloads /transmission

COPY settings.json.tmpl /transmission/settings.json.tmpl

EXPOSE 9091

VOLUME /transmission /downloads

WORKDIR /ovpn

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]