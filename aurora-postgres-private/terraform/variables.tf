# all variable are defined externally using `export TF_VAR_project_name=...` in the make.sh file
variable "project_name" {
  default = ""
}

variable "aws_region" {
  default = ""
}

variable "postgres_username" {
  default = ""
}

variable "postgres_password" {
  default = ""
}
