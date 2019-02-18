# cfssl-server

## Overview

CloudFlare's PKI/TLS toolkit and Certificate Authority Server.

## Role Variables

| Variable | Default value | Description |
| -------- | ------------- | ----------- |
| cfssl_registry_address | registry.example.com | Registry address where image is located |
| cfssl_image_name  | cfssl  | Image name to deploy |
| cfssl_image_tag   | latest | Image tag to deploy  |
| cfssl_auth_string | null   | A passphrase to use for client authentication. Can be generated using ```openssl rand -hex 16``` |
| cert_repo_url     | null   | Git repository URL containing certificates |
| cert_repo_branch  | null   | Git repository branch to clone to |
| cert_repo_ssh_key | null   | An SSH key to use for repository cloning |

## Dependencies

The role is based on Docker. So docker-engine must be installed and started before running cfssl-server

## Example Playbook

```yaml
  - hosts: cfssl-server
    become: true
    vars:
      cert_repo_url: git@github.com:my_company/cert.git
      cert_repo_branch: master
      cert_repo_ssh_key: |
        -----BEGIN RSA PRIVATE KEY-----
        MIIJKgIBAAKCAgEdjfdDRgeEWkfnfSewmblkrRjAvTJOo
        eImY082NR69McTsM5GpJAXNJgxL8rIzFV8bKthYaWWA==
        -----END RSA PRIVATE KEY-----
      cfssl_auth_string: 6b0050f5cf707b1dbd1466d14fabe2c3
    roles:
      - ../cfssl-server
```

## License

BSD

## Author Information

Constantine Kutenko <constantine.kutenko@gmail.com>
