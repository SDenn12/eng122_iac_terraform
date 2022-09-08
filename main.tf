# Who is the cloud provider? (aws)

provider "aws" {
	region = "eu-west-1"
}


# within the cloud which part of the world? (eu-west-1)

# initalise and download required packages 
# terraform init
resource "aws_instance" "app_instance" {

	# using which ami
	ami = "ami-0b47105e3d7fc023e"

	# instance type
	instance_type = "t2.micro"

	# do we need it to have public ip
	associate_public_ip_address = true

	# how to name your instance
	tags = {
		Name = "eng122_samuel_terraform_app"
	}

}