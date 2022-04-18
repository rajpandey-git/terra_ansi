locals {
  ssh_user         = "ec2-user"
  key_name         = "chef_new"
  private_key_path = "./chef_new.pem"
}

provider "aws" {
  region = var.aws_region
}
resource "aws_instance" "Jenkins_Ec2" {
  ami             = var.ami_id
  key_name        = var.key_name
  instance_type   = var.instance_type
  security_groups = [var.security_group]
  tags = {
    Name = var.tag_name
  }
  provisioner "remote-exec" {
    inline = ["echo 'wait untill SSH is ready' "]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.Jenkins_Ec2.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.Jenkins_Ec2.public_ip}, --private-key ${local.private_key_path} main.yml"
  }
}

output "Jenkins_Ec2_ip" {
  value = aws_instance.Jenkins_Ec2.public_ip
}
