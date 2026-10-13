provider "aws" {
    region = "us-east-2"
}
resource "aws_instance" "example" {
    ami           = "ami-0ea1cddefe0c4aed5"
    instance_type = "t3.micro"

    tags = {
        Name = "terraform-example"
    }
}