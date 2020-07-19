# Postgres Module

## Providers

- `aws`
- `random`

## Variables

- `name`
- `instance_type`
- `instance_type_replica = ""`
- `read_replicas = 0`
- `postgres_version = "12.3"`
- `deletion_protection = false`
- `multi_az = false`
- `allocated_storage = 20`
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

- `security_group_id`
- `master_url`
- `replica_url`
