provider "aws" {
  region = "eu-west-1"
}


resource "aws_instance" "app_instance" {

  # instance type
  instance_type = "t2.micro"

  # using which ami
  ami = data.aws_ami.server_ami.id

  # how to name your instance
  tags = {
    Name = "eng122_samuel_terraform_app"
  }


  # how to attach your pem key to the app instance
  key_name = "eng122_sam_pem"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  subnet_id = aws_subnet.pub_subnet.id

  root_block_device {
    volume_size = 8
  }

}
