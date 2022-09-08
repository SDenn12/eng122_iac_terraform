# Infrastructure as code with Terraform

### What is Terraform

Terraform is an open source, infrastructure as code software tool. It allows DevOps engineers to programatically provision the physical resources an application requires to run.

Terraform manages external resources (such as public cloud infrastructure, private cloud infrastructure, network appliances, software as a service, and platform as a service) with "providers". HashiCorp maintains an extensive list of official providers, and can also integrate with community-developed providers.

### What is Terraform used for?

- External resource management -- Terraform supports public and private cloud infrastructure, as well as network appliances and software as a service (SaaS) deployments.
- Multi-cloud deployment -- the software tool's native ability to support multiple cloud services helps increase fault tolerance.
- Multi-tier applications -- Terraform allows each resource collection to easily be scaled up or down as needed.
- Self-service clusters -- the registries make it easy for users to find prepackaged configurations that can be used as is or modified to meet a particular need.
- Software defined networking (SDN) -- Terraform's readability makes it easy for network engineers to codify the configuration for an SDN.
- Resource scheduler -- Terraform modules can stop and start resources on AWS and allow Kubernetes to schedule Docker containers.
- Disposable environments -- modules can be used to create an ad hoc, throwaway test environment for code before it's put into production.

### Benefits/Drawbacks

The advantages of using Terraform include the ability to:

- Translate HCL code into JSON;
- Support multiple cloud platforms;
- Make incremental changes to resources;
- Provide support for software-defined networking;
- Import existing resources to a Terraform state; and
- Lock modules before applying state changes to ensure that only one person can make changes at a time.

There are some disadvantages, however, to using Terraform.

- New releases and updates may have bugs.
- States have to be in sync with the infrastructure at all times.
- If users don't opt to use JSON, they will have to learn a new language, HCL.
- It doesn't have error handling.
- Renaming resources and moving them deeper into modules can be difficult.


### HCL Script to Create EC2 Instance

```
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
```
