# VPN Module

#### Todo

- Set up self-signed certificate authentication instead of password
- Use Packer to build an image rather than user data

## Providers

- `aws`
- `random`
- `template`

## Variables

- `domain`
- `instance_type`
- `public_key`
- `cert = ""`
- `ca_bundle = ""`
- `priv_key = ""`
- `vpc_id`
- `subnet_id`
- `zone_id`

## Outputs

- `security_group_id`
- `web_url`
- `ssh_command`
