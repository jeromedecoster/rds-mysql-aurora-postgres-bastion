# https://github.com/terraform-aws-modules/terraform-aws-vpc
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.5"

  name = var.project_name
  cidr = "10.0.0.0/16"
  azs  = data.aws_availability_zones.zones.names

  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  # rds require at least 2 subnet to launch an instance
  private_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.project_name
  }
}

resource "aws_default_security_group" "vpc_security_group" {
  vpc_id = module.vpc.vpc_id

  # allow all inbound traffic 
  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }

  # allow all outbound traffic
  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
# allow the ec2 instances (endorsed by the security group `aws_security_group.instance`) to
# be connected with the rds postgreSQL instance (allow inbound port 5432)
resource "aws_security_group_rule" "postgresql_ec2_instances_sg" {
  # this rule is added to the security group defined by `security_group_id`
  # and this id target the `default` security group associated with the created VPC
  security_group_id = aws_default_security_group.vpc_security_group.id

  type      = "ingress"
  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432

  # One of ['cidr_blocks', 'ipv6_cidr_blocks', 'self', 'source_security_group_id', 'prefix_list_ids']
  # must be set to create an AWS Security Group Rule
  source_security_group_id = aws_security_group.instance.id

  lifecycle {
    create_before_destroy = true
  }
}
