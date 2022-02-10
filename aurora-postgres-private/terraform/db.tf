# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster
resource "aws_rds_cluster" "cluster" {
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned"
  engine_version          = "12.7"
  cluster_identifier      = var.project_name
  master_username         = var.postgres_username
  master_password         = var.postgres_password

  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name

  backup_retention_period = 7
  skip_final_snapshot     = true
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance
resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier         = "${var.project_name}-${count.index}"
  count              = 1
  cluster_identifier = aws_rds_cluster.cluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.cluster.engine
  engine_version     = aws_rds_cluster.cluster.engine_version

  publicly_accessible = false
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = var.project_name
  }
}
