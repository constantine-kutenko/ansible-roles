# host-updater

This role is used to install a Python script ```host-updater``` and its dependencies on Linux-based hosts.

## Requirements

No specific requirements.

## Role Variables

No specific role variables.

| Variable | Default value | Description |
| ---------| ------------- | ----------- |
| host_updater_version           | 0.0.3 | Specifiles the version of ```host-updater``` script to be deployed |
| host_updater_start_schedule    | "*-*-* 00:00" | Specifies the certain time when the the script is started |
| host_updater_home_dir          | /opt/host-updater | Defines a directory where the script is installed |
| host_updater_temp_dir          | /tmp | Defines a directory where temporary files are created |
| host_updater_gitlab_repository | git@gitlab.example.com:devops/host-updater.git | Specifies a git repository with ```host-updater``` script |
| slack_webhook_url              | null | Specifies a Slack webhook to send notification to |
| pypi_repo_host                 | nexus.example.com | Specifies an FQDN of host where a local PyPi repository can be found |
| pypi_repo_url                  | null | Specifies an URL to a local PyPi repository where packages can be installed from |
| repo_ssh_key                   | null | Specifies an RSA private key to clone a repository with  ```host-updater``` from URL specified in ```host_updater_gitlab_repository``` |

## Dependencies

This role has no specific dependencies.

## Example Playbook

Please check this example of a playbook out to deploy ```host-updater``` script.

```yaml
  - hosts: localhost
    remote_user: root
    gather_facts: True
    tags: host-updater
    roles:
      - host_updater
```

Run a playbook with Ansible vault file specified:

```bash
  ansible-playbook host-updater.yml \
    --extra-vars "repo_ssh_key='-----BEGIN RSA PRIVATE KEY-----\nCERTIFICATE\n-----END RSA PRIVATE KEY-----\n'"
```

## License

BSD

## Author Information

Constantine Kutenko <constantine.kutenko@gmail.com>
