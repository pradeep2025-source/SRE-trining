variable "vpc_id" {}
variable "subnets" {}
variable "db_user" {}
variable "db_password" {
  sensitive = true
}
