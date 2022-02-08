resource "aws_db_instance" "db_instance" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = var.mysql_identifier
  username             = var.mysql_username
  password             = var.mysql_password
  parameter_group_name = "default.mysql5.7"

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  # vpc_security_group_ids = [aws_security_group.db.id]
  vpc_security_group_ids = [
    module.vpc.default_security_group_id
  ]
  publicly_accessible = false
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = var.project_name
  }
}
