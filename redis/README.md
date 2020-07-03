# Redis Module

## Providers

- `aws`

## Variables

- `name`
- `domain`
- `instance_type`
- `redis_version = "5.0.6"`
- `redis_port = 6379`
- `read_replicas = 0`
- `multi_az = false`
- `automatic_failover = null`
- `backup_retention = 0`
- `backup_window = ""`
- `maintenance_window = ""`
- `security_group_ids = []`
- `vpc_id`
- `subnet_ids`
- `zone_id`

## Outputs

- `master_url`
- `replica_url`
