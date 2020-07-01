resource "random_pet" "user" {
  length = 1
}

resource "random_password" "pass" {
  length  = 32
  special = false
}

resource "aws_db_subnet_group" "main" {
  name       = var.name
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "main" {
  engine                                = "postgres"
  engine_version                        = var.postgres_version
  identifier                            = var.name
  final_snapshot_identifier             = "${var.name}-final"
  instance_class                        = var.instance_type
  deletion_protection                   = var.deletion_protection
  multi_az                              = var.multi_az
  performance_insights_enabled          = var.performance_insights
  performance_insights_retention_period = var.performance_insights_retention
  monitoring_interval                   = var.monitoring_interval
  backup_retention_period               = var.backup_retention
  backup_window                         = var.backup_window
  maintenance_window                    = var.maintenance_window
  apply_immediately                     = var.maintenance_window == "" ? true : false
  storage_encrypted                     = ! contains(local.non_encrypted_instance_types, var.instance_type)
  max_allocated_storage                 = lookup(local.max_allocated_storage, regex("(?i:^db\\..+\\.(?:[0-9]+)?x?(.+))", var.instance_type)[0])
  allocated_storage                     = 20
  db_subnet_group_name                  = aws_db_subnet_group.main.id
  vpc_security_group_ids                = [aws_security_group.main.id]
  name                                  = var.name
  username                              = random_pet.user.id
  password                              = random_password.pass.result
  port                                  = 5432
  publicly_accessible                   = false
}

resource "aws_db_instance" "read" {
  count                        = var.read_replicas
  identifier                   = "${var.name}-read${count.index + 1}"
  instance_class               = var.instance_type_replica != "" ? var.instance_type_replica : var.instance_type
  replicate_source_db          = aws_db_instance.main.identifier
  max_allocated_storage        = aws_db_instance.main.max_allocated_storage
  storage_type                 = aws_db_instance.main.storage_type
  storage_encrypted            = aws_db_instance.main.storage_encrypted
  publicly_accessible          = aws_db_instance.main.publicly_accessible
  maintenance_window           = aws_db_instance.main.maintenance_window
  deletion_protection          = aws_db_instance.main.deletion_protection
  performance_insights_enabled = aws_db_instance.main.performance_insights_enabled
  skip_final_snapshot          = true
}
