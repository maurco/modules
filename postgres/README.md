# Postgres Module

## Providers

- `aws`
- `random`

## Variables

- `name`
- `domain`
- `instance_type`
- `instance_type_replica = ""`
- `postgres_version = "12.3"`
- `deletion_protection = false`
- `read_replicas = 0`
- `multi_az = false`
- `backup_retention = 0`
- `backup_window = ""`
- `maintenance_window = ""`
- `monitoring_interval = 0`
- `performance_insights = false`
- `performance_insights_retention = 0`
- `security_group_ids = []`
- `vpc_id`
- `subnet_ids`
- `zone_id`

## Outputs

- `master_url`
- `replica_url`
