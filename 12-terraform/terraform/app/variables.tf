variable "env_prefix" {}
variable "region" {}
variable "app_name_prefix" {}
variable "jenkins_user_arn" {
  default = "arn:aws:iam::458405758445:user/jenkins"
}
variable "alex_user_arn" {
  default = "arn:aws:iam::458405758445:user/admin"
}
