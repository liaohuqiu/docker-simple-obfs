This is the [simple-obfs](https://github.com/shadowsocks/simple-obfs) docker image. It's based on alpine and only 4MB.

Since there are a lot of parameters and you may want to use simple-obfs in various ways, so I did not provide any entrypoint for this image.

You can run obfs-server or obfs-local in any way you wish.

### Usage

The simple-obfs contains: obfs-server and obfs-local. obfs-server is the server side and obfs-local is the client side.

Suppose the shadowsocks is listening at $ip:$port, for example: 127.0.0.1:8388, or even on the other server.

```
obfs-server -p 8443 --obfs tls -r 127.0.0.1:8388
```

Now your obfs-server will be listening on `0.0.0.0:8443`. It will process the traffic from the client side. Deobfuscate it then send to the shadowsocks on `127.0.0.1:8388`.

On the client side:

```
obfs-local -s your_server_ip -p 8443 --obfs tls -l 8388 --obfs-host www.bing.com
```

Then it will be listening at the 0.0.0.0:8388, communicating with the server. Once it receives the traffic from shadowsocks, it will obfuscate it and sent it to the server.

So the shadowsocks client or the ss-redir can treat it as a shadowsocks server.

#### Using docker

```
docker run -d --restart=always -p 8443:8443 --name simple-obfs liaohuqiu/simple-obfs obfs-server -p 8443 --obfs tls -r $shadowsocks-ip:$shadowsocks-port
```

If your shadowsocks are running on your host, listening at 127.0.0.0, and your container is not using `--net=host`. The IP address 127.0.0.1 is the loopback IP in the container,

You can use the docker0 IP or the host interface IP. But that depends on which IP the shadowsocks is listening on.
