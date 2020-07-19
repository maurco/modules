# VPN Module

#### Todo

- Connect to RDS instance rather than SQLite
- Set up self-signed certificate authentication for OpenVPN instead of password

## Providers

- `aws`
- `template`

## Variables

- `name`
- `instance_type`
- `public_key`
- `certificate_bucket`
- `certificate_cert = "cert.pem"`
- `certificate_full_chain = "fullchain.pem"`
- `certificate_priv_key = "privkey.pem"`
- `vpc_id`
- `subnet_id`
- `zone_id`
- `security_group_ids`

## Outputs

- `web_url`
- `ssh_url`
