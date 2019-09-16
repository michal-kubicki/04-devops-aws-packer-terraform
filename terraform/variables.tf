variable "inst" {
  default = 1
}
variable "aws_region" {
  default = "eu-west-2"
}
variable "ec2_type" {
  default = "t2.micro"
}
variable "ssh_key" {
  default = "London"
}

variable "tag_name" {
  default = "test_ec2"
}
locals{
  http_port = 80
  https_port = 443
  ssh_port    = 22
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  http_protocol = "HTTP"
  all_ips      = ["0.0.0.0/0"]
}