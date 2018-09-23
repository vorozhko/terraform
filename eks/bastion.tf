
resource "aws_instance" "bastion" {
  ami                         = "ami-0ac019f4fcb7cb7e6"#"ami-00035f41c82244dab"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "xps"
  security_groups             = ["${aws_security_group.bastion-sg.name}"]
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
