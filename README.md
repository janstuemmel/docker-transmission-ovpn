# docker transmission ovpn

A docker image that binds a transmission-daemon to the ovpn tunnel ip address after initializing a ovpn connection. When the openvpn connection shuts down, transmission can't access the outside network. It will also gracefully shut down (and restart) transmission when openvpn exits. 

It's heavily inspired by [haugene/docker-transmission-openvpn](https://github.com/haugene/docker-transmission-openvpn)
but without all the complexity. What this image does is easily to understand, although it is not that convenient to use and doesn't offer all the configuration options.

I also created [janstuemmel/docker-deluge-ovpn](https://github.com/janstuemmel/docker-deluge-ovpn), this image takes a different approach by setting up a ufw firewall that blocks connection to the ouside network except openvpn.

## Usage 

Create a folder e.g. `./ovpn` with all your .ovpn config files or just one. This image will select one randomly.  

For username/password authentication, see `command` section in the `docker-compsoe.yml` file.

```yml
version: 3

services:
  app:
    image: janstuemmel/transmission-ovpn 
    cap_add:
      - net_admin
    devices:
      - /dev/net/tun
    # you can append args to openvpn
    # maybe you need username/password 
    # authentication, add a file next
    # to your ovpn config files
    # this will override the arguments
    # defined in the ovpn file
    command: --auth-user-pass auth.txt
    environment:
      # Set the transmission peer port
      # because it is not editable via 
      # a remote client, useful when
      # your vpn provider supports
      # static port forwarding
      - TRANSMISSION_PEER_PORT=12345
      # enable basic auth for transmission
      - TRANSMISSION_AUTH=true
      # set a username
      - TRANSMISSION_USERNAME=userfoo
      # set a password
      - TRANSMISSION_PASSWORD=s3cret
      # specify a single ovpn config
      # instead of choosing one randomly
      - OVPN_CONIFG=myconf.ovpn
    volumes:
      # mount your *ovpn files into the 
      # container, this is REQUIRED
      - ./ovpn:/ovpn
      # mount your downloads folder
      - ./downloads:/downloads
    ports:
      # transmission clients can connect
      # to this port
      - 9091:9091
```

