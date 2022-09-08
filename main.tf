# Who is the cloud provider? (aws)

provider "aws" {
  region = "eu-west-1"
}


# within the cloud which part of the world? (eu-west-1)

# initalise and download required packages 
# terraform init

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "eng122_sam_tf"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "eng122_sam_tf"
  }
}

resource "aws_subnet" "pub_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"
  tags = {
    Name = "eng122_sam_tf_public"
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "eng122_sam_rt_tf"
  }
}

resource "aws_route" "default_route" {

  route_table_id         = aws_route_table.pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "asoc" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pub_rt.id

}

resource "aws_security_group" "app_sg" {
  name        = "eng122_tf_sam_sg"
  description = "created on terriform"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # can use a list for this [0.0.0.0/0, 1.1.1.1/1] etc
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_instance" {

  # instance type
  instance_type = "t2.micro"

  # using which ami
  ami = data.aws_ami.server_ami.id

  # do we need it to have public ip
  associate_public_ip_address = true

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
