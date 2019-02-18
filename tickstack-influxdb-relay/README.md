# tickstack-influxdb-relay

## Purpose

This role is used to install and configure an InfluxDB-relay service into a LXD container on a Head Node.

## Overview

This project adds a basic high availability layer to InfluxDB. With the right architecture and disaster recovery processes, this achieves a highly available setup.

## Requirements

No specific requirements.

## Role Variables

| Variable | Default | Description |
|----------|---------|-------------|
|`influxdb_relay_http_bind_address`|`0.0.0.0`| An IPv4 address to bind on while a service is up and running. |
|`influxdb_relay_http_bind_port`|`9096`| A TCP port for HTTP connections that InfluxDB-Relay will listen on. |
|`influxdb_relay_url`|``| A URL to access InfluxDB-Relay. |
|`influxdb_relay_udp_enabled`|`False`| Define whether UDP protocol is used or not. |
|`influxdb_relay_udp_bind_address`|`0.0.0.0`| An IPv4 address to bind on while a service is up and running. |
|`influxdb_relay_udp_bind_port`|`9096`| A TCP port for UDP connections that InfluxDB-Relay will listen on. |
|`influxdb_relay_udp_read_buffer`|`0`| Define a buffer size to buffer failed requests for UDP backends. |
|`influxdb_relay_udp_precision`|`n`| Define whether precision is used. Can be n, u, ms, s, m, h. |
|`influxdb_relay_ssl_certificate`|``| Store a path to an SSL certificate |
|`influxdb_relay_user`|`influxdb-relay`| System account that is used by InfluxDB-Relay service. |
|`influxdb_relay_group`|`influxdb-relay`| System group that is used by InfluxDB-Relay service. |
|`influxdb_relay_http_hosts`|``| A list of InfluxDB hosts that are used to store data received from Telegraf agents using HTTP. |
|`influxdb_relay_udp_hosts`|``| A list of InfluxDB hosts that are used to store data received from Telegraf agents using UDP. |

## Dependencies

This role depends on tickstack-influxdb role.

## Example Playbook

````yaml
- hosts: tickstack-server
  any_errors_fatal: true
  become: yes
  roles:
    - role: tickstack-influxdb-relay
````

## License

BSD

## Author Information

Constantine Kutenko <constantine.kutenko@gmail.com>
