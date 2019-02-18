# ansible-roles

A set of Ansible roles, playbooks and hints

### Listing of all roles

| Name | Use case | Description |
|------|----------|-------------|
| bind | Install and start a bind DNS server | Provides name resolving |
| cfssl-client | Install CloudFlare's PKI/TLS client as a systemd service | Issues and renews SSL certificated for a host |
| cfssl-server | Install CFSSL Server | Holds an intermediate certificate and accepts requests for issueing and/or renewing hosts' certificates |
| host-updater | Install a script and a respective service| Updates RHEL-based host |
| jenkins | Install Jenkins | |
| tickstack-telegraf | Install Telegraf as an agent for TICK Stack| Part of infrastructure and applications monitoring approach |
| tickstack-influxdb | Install InfluxDB | Stores timestamped data received from sources |
| tickstack-influxdb-relay | Install InfluxDB-relay | Provides basic a HA layer to InfluxDB |
| tickstack-chronograph | Install Chronograf services | Visualizea the data from InfluxDB |
| tickstack-kapacitor | Install Kapacitor | Detects anomalies and provides alerting |
