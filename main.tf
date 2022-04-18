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
      user        = "ec2-user"
      private_key = file("./chef_new.pem")
      host        = aws_instance.Jenkins_Ec2.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.Jenkins_Ec2.public_ip}, --private-key ${"./chef_new.pem"} main.yml"
  }
}

output "Jenkins_Ec2_ip" {
  value = aws_instance.Jenkins_Ec2.public_ip
}
