variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     = "chef_new"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "Chef_SG"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "TERA_MERA"
}

variable "ami_id" {
  description = "Ami id for ec2"
  default     = "ami-087c17d1fe0178315"

}

