# Redis Module

## Providers

- `aws`
- `random`

## Variables

- `name`
- `instance_type`
- `redis_version = "5.0.6"`
- `redis_port = 6379`
- `read_replicas = 0`
- `automatic_failover = false`
- `backup_retention = 0`
- `backup_window = ""`
- `maintenance_window = ""`
- `vpc_id`
- `subnet_ids`
- `zone_id`

## Outputs

- `security_group_id`
- `master_url`
- `replica_url`
