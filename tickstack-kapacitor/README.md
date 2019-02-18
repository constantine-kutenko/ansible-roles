# tickstack-kapacitor

## Purpose

This role is used to install and configure Kapacitor service into a LXD container.

## Overview

Kapacitor is an open source data processing framework that makes it easy to create alerts, run ETL jobs and detect anomalies. Kapacitor is the final piece of the TICK stack.

## Requirements

No specific requirements.

## Role Variables

| Variable | Default | Description |
|----------|---------|-------------|
|`kapacitor_bind_address`|`127.0.0.1`| An IPv4 address to bind on while a service is up and running. |
|`kapacitor_bind_port`|`9092`| A TCP port that Kapacitor will listen on. |
|`kapacitor_url`|``| A URL which Kapacitor will be available on |
|`kapacitor_influxdb_username`|`kapacitor`| The username that is used to authorize Kapacitor in database. |
|`kapacitor_influxdb_password`|``| The password that is used to authorize Kapacitor in database. |
|`kapacitor_service_name: Kapacitor`|`Kapacitor`| A name of Kapacitor account displayed in Chronograf dashboard |

## Dependencies

This role depends on tickstack-influxdb role.

## Example Playbook

````yaml
- hosts: tickstack-server
  any_errors_fatal: true
  become: yes
  roles:
    - role: tickstack-kapacitor
````

## License

BSD

## Author Information

Constantine Kutenko <constantine.kutenko@gmail.com>
