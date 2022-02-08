output "ec2_public_dns" {
  value = aws_instance.instance.public_dns
}

output "ec2_security_group_id" {
  value = aws_security_group.instance.id
}

output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "db_instance_endpoint" {
  value = aws_rds_cluster.cluster.endpoint
}

output "ec2_subnet_id" {
  value = module.vpc.public_subnets[0]
}
