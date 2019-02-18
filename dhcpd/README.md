# dhcpd

## Overview

ISC DHCP is open source software that implements the Dynamic Host Configuration Protocol for connection to an IP network. It offers a complete solution for implementing DHCP servers, relay agents, and clients for small local networks to large enterprises. ISC DHCP solution supports both IPv4 and IPv6, and is suitable for use in high-volume and high-reliability applications. DHCP is available for free download under the terms of the ISC License, a BSD style license.

This role allows to install and configure a failover and load balancing cluster of two nodes. The first node from an inventory file is considered as a primary node and the second node is considered as a secondary one.

## Requirements

This role requires using the role `dhcpd-static-entries` in order to fill out `static-entries.conf` using information from respective inventory file.

## Role Variables

See the example of playbook.

## Dependencies

This role has no specific dependencies.

## Example Playbook

Please check this example of a playbook out to deploy ```dhcpd-failover```.

```yaml
- hosts: "{{ host_group }}"
  become: yes
  gather_facts: True
  vars:
    dhcpd_ddns_updates: True
    domain_name: example.com
    dhcpd_dns_servers:
      - 192.172.253.200
      - 192.172.253.202
    dhcpd_ntp_servers:
      - 192.172.253.200
      - 192.172.253.202
    dhcpd_tftp_server: 192.172.253.200
    dhcpd_failover_enabled: true
    dhcpd_key:
      name: dhcp_local_key
      algorithm: hmac-md5
      secret: blasdfsdfsdasjjqspcmsbwggv==
    dhcpd_dns_forward_zones:
      - zone: example.com.
        key: "{{ dhcpd_key.name }}"
    dhcpd_dns_reverse_zones:
      - zone: 253.172.192.in-addr.arpa.
        key: "{{ dhcpd_key.name }}"
    dhcpd_subnets:
      - name: default
        subnet: 192.172.253.0
        netmask: 255.255.255.0
        authoritative: yes
        options:
          - option: routers
            value: 192.172.253.1
        pool:
          failover_peer: "{{ dhcpd_failover_name }}"
          range: "192.172.253.100 192.172.253.199"
          options:
            - option: subnet-mask
              value: 255.255.255.0
            - option: ntp-servers
              value: "192.172.253.200, 192.172.253.202"
      - name: legacy
        subnet: 172.16.5.0
        netmask: 255.255.255.0
        authoritative: yes
        options: []
        pool:
          failover_peer: "{{ dhcpd_failover_name }}"
          range: "172.16.5.100 172.16.5.199"
          options:
            - option: subnet-mask
              value: 255.255.255.0
            - option: routers
              value: 172.16.5.254
    dhcpd_static_entries: []
  tags:
    - dhcp-failover
  roles:
    - role: dhcpd
    - role: dhcpd-static-entries
```

Example of inventory file:

```ini
  [dhcp-hosts]
  kickstart01     ansible_host=192.172.253.63 dhcp_type=primary   active_mac=88:51:b6:e8:2e:a6
  kickstart02     ansible_host=192.172.253.64 dhcp_type=secondary   active_mac=88:51:f1:a3:6f:a7
```

Run a playbook pointing some variables. The most important variable is 'host_group'. It addresses the respective group of hosts in the inventory file.

```bash
  ansible-playbook \
    -i ../inventory.hosts \
    ./datacerter.yml \
    --extra-vars host_group=dhcp-hosts
```

After successful deploying the role one may want to test work DHCP servers in a network:

```bash
  nmap --script broadcast-dhcp-discover -e eth0
```

## License

BSD

## Author Information

Constantine Kutenko <constantine.kutenko@gmail.com>
