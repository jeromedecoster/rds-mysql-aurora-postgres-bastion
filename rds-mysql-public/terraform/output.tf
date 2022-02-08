# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#attributes-reference
output "db_instance_address" {
  value = aws_db_instance.db_instance.address
}
