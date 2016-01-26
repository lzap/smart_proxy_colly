# Smart Proxy Colly plugin

Probes smart proxy and sends internal data and notifications into collectd via
UNIX socket.

## Features

* Real time data from Smart Proxy:
  * Number of requests
  * Prequest processing time
  * Initialized modules
* Notifications
* Communication with local collectd via UNIX socket.

## Planned features

* Sending notifications on specific events (e.g. errors).

## Installation

See
[How_to_Install_a_Plugin]
(http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)
for how to install Foreman plugins

## Usage

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

Best to use with [Foreman Colly](https://github.com/lzap/smart_proxy_colly).

## Copyright

Copyright (c) 2015 Lukas Zapletal, Red Hat

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

