# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
# resource "aws_db_instance" "my-rds" {
#   allocated_storage           = 200
#   allow_major_version_upgrade = null
#   apply_immediately           = null
#   auto_minor_version_upgrade  = true
#   availability_zone           = "us-east-1a"
#   backup_retention_period     = 7
#   backup_target               = "region"
#   backup_window               = "06:38-07:08"
#   ca_cert_identifier          = "rds-ca-rsa2048-g1"
#   character_set_name          = null
#   copy_tags_to_snapshot       = true
#   custom_iam_instance_profile = null
#   customer_owned_ip_enabled   = false
#   db_name                     = "dynamicwebappdb"
#   db_subnet_group_name        = "db-subnets"
#   dedicated_log_volume        = false
#   delete_automated_backups    = true
#   deletion_protection         = false
#   #   domain                                = null
#   #   domain_auth_secret_arn                = null
#   #   domain_dns_ips                        = []
#   #   domain_fqdn                           = null
#   #   domain_iam_role_name                  = null
#   #   domain_ou                             = null
#   enabled_cloudwatch_logs_exports       = []
#   engine                                = "mysql"
#   engine_lifecycle_support              = "open-source-rds-extended-support-disabled"
#   engine_version                        = "8.0.39"
#   final_snapshot_identifier             = null
#   iam_database_authentication_enabled   = false
#   identifier                            = "dev-rds-db"
#   identifier_prefix                     = null
#   instance_class                        = "db.t3.micro"
#   iops                                  = 3000
#   kms_key_id                            = "arn:aws:kms:us-east-1:473208108378:key/cd2e2109-a499-4f63-a674-8a29e175649d"
#   license_model                         = "general-public-license"
#   maintenance_window                    = "thu:08:27-thu:08:57"
#   manage_master_user_password           = null
#   master_user_secret_kms_key_id         = null
#   max_allocated_storage                 = 1000
#   monitoring_interval                   = 60
#   monitoring_role_arn                   = "arn:aws:iam::473208108378:role/rds-monitoring-role"
#   multi_az                              = false
#   nchar_character_set_name              = null
#   network_type                          = "IPV4"
#   option_group_name                     = "default:mysql-8-0"
#   parameter_group_name                  = "default.mysql8.0"
#   password                              = null # sensitive
#   performance_insights_enabled          = false
#   performance_insights_kms_key_id       = null
#   performance_insights_retention_period = 0
#   port                                  = 3306
#   publicly_accessible                   = false
#   replica_mode                          = null
#   replicate_source_db                   = null
#   skip_final_snapshot                   = true
#   snapshot_identifier                   = null
#   storage_encrypted                     = true
#   storage_throughput                    = 125
#   storage_type                          = "gp3"
#   tags                                  = {}
#   tags_all                              = {}
#   timezone                              = null
#   upgrade_storage_config                = null
#   username                              = "inyeza"
#   vpc_security_group_ids                = [aws_security_group.rds-sg.id]
#}
resource "aws_db_subnet_group" "my-db-subnets" {
  name       = "db-subnets"
  subnet_ids = [aws_subnet.my_private_subnet3.id, aws_subnet.my_private_subnet4.id]

  tags = {
    Name = "db-subnets"
  }
}

# create rds database
resource "aws_db_instance" "dev-rds-db" {
  allocated_storage       = 200
  storage_type            = "gp3"
  db_name                 = "dynamicwebappdb"
  engine                  = "mysql"
  engine_version          = "8.0.39"
  identifier              = "dev-rds-db"
  instance_class          = "db.t3.micro"
  username                = "inyeza"
  password                = "Inyeza1986?"
  publicly_accessible     = false
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.rds-sg.id]
  backup_retention_period = 7
  skip_final_snapshot     = true

}
