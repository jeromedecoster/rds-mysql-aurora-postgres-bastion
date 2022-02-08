# all variable are defined externally using `export TF_VAR_project_name=...` in the make.sh file
variable "project_name" {
  default = ""
}

variable "aws_region" {
  default = ""
}

variable "mysql_identifier" {
  default = ""
}

variable "mysql_username" {
  default = ""
}

variable "mysql_password" {
  default = ""
}
