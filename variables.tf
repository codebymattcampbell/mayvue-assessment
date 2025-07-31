variable "region" {
  default = "us-west-2"
}
variable "windows_ami" {
  default = "ami-0c55b159cbfafe01e"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_pair" {
  default = "my-key-pair"
}
variable "subnet_id" {
  default = "subnet-0bb1c79de3EXAMPLE"
}
variable "security_group_id" {
  default = "sg-0c55b159cbfafe01e"
}
