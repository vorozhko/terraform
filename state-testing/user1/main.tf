resource "aws_instance" "example" {
  ami           = "ami-2d39803a"
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    bucket         = "vorozhko-terraform-state-file"
    key            = "example/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform_example_lock"
  }
}
