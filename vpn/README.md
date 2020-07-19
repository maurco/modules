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
- `cert_path = "cert.pem"`
- `full_chain_path = "fullchain.pem"`
- `priv_key_path = "privkey.pem"`
- `vpc_id`
- `subnet_id`
- `zone_id`
- `security_group_ids`

## Outputs

- `web_url`
- `ssh_url`
