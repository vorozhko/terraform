resource "aws_instance" "ubuntu" {
  ami                    = "ami-a4dc46db"
  instance_type          = "t2.micro"
  key_name               = "xps"
  vpc_security_group_ids = ["sg-0be916449847b4d45"]
}

output "ip" {
  value = "${aws_instance.ubuntu.public_ip}"
}
