data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "xps"
  vpc_security_group_ids      = ["${aws_security_group.bastion-sg.id}"]
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  tags = {
      Name = "bastion",
      Terrafrom = "True"
  }
}


resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}
