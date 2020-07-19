resource "aws_elasticache_subnet_group" "main" {
  name       = random_id.main.hex
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id          = random_id.main.hex
  replication_group_description = " "
  engine                        = "redis"
  engine_version                = var.redis_version
  port                          = var.redis_port
  node_type                     = var.instance_type
  snapshot_retention_limit      = var.backup_retention
  snapshot_window               = var.backup_window
  maintenance_window            = var.maintenance_window
  apply_immediately             = var.maintenance_window == "" ? true : false
  subnet_group_name             = aws_elasticache_subnet_group.main.id
  security_group_ids            = [aws_security_group.main.id]
  number_cache_clusters         = var.read_replicas + 1
  automatic_failover_enabled    = var.automatic_failover
  at_rest_encryption_enabled    = true
  transit_encryption_enabled    = true

  # https://github.com/terraform-providers/terraform-provider-aws/issues/13706
  # multi_az                      = var.multi_az

  lifecycle {
    create_before_destroy = true
  }
}
