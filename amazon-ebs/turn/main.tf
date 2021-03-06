data "aws_ami" "packer_turn" {
  most_recent = true

#  filter {
#    name   = "name"
#    values = ["packer-turn-ami-*"]
#  }
#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]
#  }
#
#  owners = ["610596688011"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}

resource "aws_instance" "turn" {
  ami                    = data.aws_ami.packer_turn.id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.ssh_key_name
  tags = {
    Name = "jitsi-turn-server-${var.domain_name}"
  }
  
}

