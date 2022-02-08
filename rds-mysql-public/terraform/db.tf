# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "db_instance" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = var.mysql_identifier
  username             = var.mysql_username
  password             = var.mysql_password
  parameter_group_name = "default.mysql5.7"

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#db_subnet_group_name
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#vpc_security_group_ids
  vpc_security_group_ids = [aws_security_group.vpc_sg.id]

  publicly_accessible = true
  skip_final_snapshot = true
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = var.project_name
  }
}