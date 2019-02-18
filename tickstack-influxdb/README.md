# tickstack-influxdb

## Purpose

This role is used to install and configure an InfluxB service into a LXD container.

# Overview

InfluxDB is a time series database built from the ground up to handle high write and query loads. It is the second piece of the TICK stack. InfluxDB is meant to be used as a backing store for any use case involving large amounts of timestamped data, including DevOps monitoring, application metrics, IoT sensor data, and real-time analytics.

## Requirements

No specific requirements.

## Role Variables

| Variable | Default | Description |
|----------|---------|-------------|
|`influxdb_ip_address`|``| An IPv4 address to provide access to database for Telegraf agents. |
|`influxdb_bind_address`|`0.0.0.0`| An IPv4 address to bind on while a service is up and running. |
|`influxdb_http_bind_port`|`8086`| A TCP port for HTTP connections that InfluxDB will listen on. |
|`influxdb_udp_bind_port`|`8089`| A TCP port for UDP connections that InfluxDB will listen on. |
|`influxdb_admin_username`|`admin`| The username that is used to authorize InfluxDB in database. |
|`influxdb_admin_password`|``| The password that is used to authorize InfluxDB in database. |
|`influxdb_admin_users`|``| A list of users with admin privileges in database. |
|`influxdb_service_users`|``| A list of users for TICK Stack services. |
|`influxdb_database_name`|`telegraf`| The default InfluxDB database name. |

## Dependencies

This role has no specific dependencies.

## Example Playbook

````yaml
- hosts: influxdb-server
  any_errors_fatal: true
  become: yes
  roles:
    - role: tickstack-influxdb
````

## Database restore procedure

The following instuction describes on how to perform steps to restore InfulxDB metastore and database.
Let's assume that we already have backup created by Duply and called tickstack-influxdb.

1. Unpack Duply backup to a temporary directory (/tmp/restore) and unpack influxdb.tar which contains InfluxDB metastore and database files.

````bash
mkdir -p /tmp/restore 2>/dev/null
duply tickstack-influxdb restore /tmp/restore/
tar -xf /tmp/restore/tmp/influxdb-duply/influxdb.tar -C /tmp/test
````

2. Restore InfluxDB metastore and database to default location (/var/lib/influxdb).
   Note: Restoring from backup is only supported while the InfluxDB daemon is stopped.

````bash
influxd restore \
	-metadir /var/lib/influxdb/meta \
	-database telegraf \
	-datadir /var/lib/influxdb/data \
	/tmp/restore/tmp/influxdb_backup
````

3. Once the backed up data has been recovered, the permissions on the shards may no longer be accurate.
   To ensure the file permissions are correct, please run the following command:

````bash
chown -R influxdb:influxdb /var/lib/influxdb
````

4. Once the data and metastore are recovered andpermittions are set, it’s time to start the database service:

````bash
systemctl start influxdb.service
````

5. The final step is a quick check that database was restored successfully and presents.
   Here default credentials are used. One needs to change them to actual ones.

````bash
influx \
    -username 'admin' \
    -password 'password' \
    -execute 'show databases'
````

## License

BSD

## Author Information

Constantine Kutenko <constantine.kutenko@gmail.com>
