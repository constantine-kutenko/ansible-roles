# tickstack-agent

## Purpose

This role is used to install and configure a Telegraf service into a LXD container on a Head Node.

## Overview

Telegraf is a plugin-driven server agent for collecting & reporting metrics, and is the first piece of the TICK stack. Telegraf has plugins to source a variety of metrics directly from the system it’s running on, pull metrics from third party APIs, or even listen for metrics via a statsd and Kafka consumer services. It also has output plugins to send metrics to a variety of other datastores, services, and message queues, including InfluxDB, Graphite, OpenTSDB, Datadog, Librato, Kafka, MQTT, NSQ, and many others.

## Requirements

No specific requirements.

## Role Variables

| Variable | Default | Description |
|----------|---------|-------------|
|`telegraf_influxdb_username`|`telegraf`| The username that is used to authorize agent in database. |
|`telegraf_influxdb_password`|``| The password that is used to authorize agent in database. | 
|`telegraf_influxdb_database`|`telegraf`| The name of the database to store the data from TICK Stack agents. |

## Dependencies

This role depends on tickstack-influxdb-relay role.

## Example Playbook

Example on how to apply the role to a container of a host:

````yaml
- hosts: tickstack-agent
  any_errors_fatal: true
  become: yes
  roles:
    - role: tickstack-agent
````

License
-------

BSD

Author Information
------------------

Constantine Kutenko <constantine.kutenko@gmail.com>
