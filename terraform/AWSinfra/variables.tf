variable "region" { default = "us-west-2" }
variable "env"    { default = "dev" }

variable "db_user" {}
variable "db_password" {
  sensitive = true
}
