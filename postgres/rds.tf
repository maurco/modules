resource "aws_db_subnet_group" "main" {
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "main" {
  engine                                = "postgres"
  engine_version                        = var.postgres_version
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
  allocated_storage                     = var.allocated_storage
  storage_encrypted                     = ! contains(local.non_encrypted_instance_types, var.instance_type)
  max_allocated_storage                 = lookup(local.max_allocated_storage, regex("(?i:^db\\..+\\.(?:[0-9]+)?x?(.+))", var.instance_type)[0])
  db_subnet_group_name                  = aws_db_subnet_group.main.id
  vpc_security_group_ids                = [aws_security_group.main.id]
  name                                  = random_pet.dbname.id
  username                              = random_pet.dbuser.id
  password                              = random_password.dbpass.result
  port                                  = var.postgres_port
  final_snapshot_identifier             = "final"
  publicly_accessible                   = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "read" {
  count                                 = var.read_replicas
  instance_class                        = var.instance_type_replica != "" ? var.instance_type_replica : var.instance_type
  replicate_source_db                   = aws_db_instance.main.identifier
  performance_insights_enabled          = aws_db_instance.main.performance_insights_enabled
  performance_insights_retention_period = aws_db_instance.main.performance_insights_retention_period
  monitoring_interval                   = aws_db_instance.main.monitoring_interval
  maintenance_window                    = aws_db_instance.main.maintenance_window
  apply_immediately                     = aws_db_instance.main.apply_immediately
  storage_encrypted                     = aws_db_instance.main.storage_encrypted
  max_allocated_storage                 = aws_db_instance.main.max_allocated_storage
  publicly_accessible                   = aws_db_instance.main.publicly_accessible
  skip_final_snapshot                   = true
}
