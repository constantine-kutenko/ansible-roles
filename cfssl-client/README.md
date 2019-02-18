# cfssl-client

## Overview

This role is used to install and configure a CloudFlare's PKI/TLS (CFSSL) client and import enterprise intermediate CA certificate.

## Requirements

No specific requirements.

## Role Variables

| Variable | Default value | Description |
| -------- | ------------- | ----------- |
| cfssl_client_version | 1.3.2               | A version of CFSSL client to be installed. |
| cfssl_client_start_schedule | *-*-* 00:00  | Specifies the time when certificate verifying and updating service starts. |
| cfssl_client_bin_dir  | /opt/cfssl-client  | Specifies a default directory for CFSSL client binary files |
| cfssl_client_data_dir | /var/lib/cfssl-client | Specifies a default directory for storing a root and a host certificates. |
| cfssl_client_expiration_threshold | 7       | Defines an amount of days before expiration date when service tries to update one. |
| cfssl_server_address  | localhost | Specifies a domain name or an IP address for CFSSL server.  |
| cfssl_server_port     | 8888               | Specifies a TCP port to send requests to. |
| cfssl_requested_ips   | null               | List of IPs cfssl will generate certificate for. Mandatory |
| slack_webhook_url     | null               | Specifies a Slack webhook URL to send notifications to. |
| cfssl_download_url    | null               | Defines an URL for downloading CFSSL binaries as a archived file. |
| curl_request_timeout  | 30                 | Defines timeout in seconds for requests when certificate is requested. |
| cfssl_server_token    | null               | Defines a token that is used to be authenticated with CFSSL server. |
| cfssl_root_certificate | null               | Defines a chain of a root and intermediate certificates to be imported into a system certificate store. |

## Dependencies

This role has no specific dependencies.

## Example Playbook

Please check this example of a playbook out to deploy ```CFSSL client```.

```yaml
  - hosts: cfssl-client
    become: yes
    gather_facts: True
    tags: cfssl-client
    roles:
      - role: cfssl-client
```

Run a playbook pointing some variables:

```bash
  ansible-playbook cfssl-client.yml \
    --extra-vars "cfssl_server_address=cfssl.example.com" \
    --extra-vars "cfssl_server_port=443" \
    --extra-vars "cfssl_server_token=some_token_to_be_sent_to_cfssl_server" \
    --extra-vars "cfssl_client_expiration_threshold=7" \
    --extra-vars "cfssl_root_certificate='-----BEGIN CERTIFICATE-----\nCERTIFICATE\n-----END CERTIFICATE-----\n'"
```

## License

BSD

## Author Information

Constantine Kutenko <constantine.kutenko@gmail.com>
