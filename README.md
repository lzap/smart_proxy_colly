# Smart Proxy Colly plugin

Probes smart proxy and sends internal data and notifications into collectd via
UNIX socket.

Collectd daemon must be configured on the same host and accepting connections:

    LoadPlugin unixsock

    <Plugin unixsock>
        SocketFile "/var/run/collectd-unixsock"
        SocketGroup "foreman-proxy"
        SocketPerms "0660"
        DeleteSocket false
    </Plugin>

Data can be then sent over the network to the central collectd instance
running on the Foreman server where it can be accessed by Foreman Colly
plugin:

    LoadPlugin network

    <Plugin "network">
        Server foreman.example.com
    </Plugin>
