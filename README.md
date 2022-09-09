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

### Setup Environment Variable (windows)

- Go to "Edit the system environment variables"
- Create aws access key and secret key environment variables such that the variable names are as listed below:
  - aws_secret_access_key
  - aws_access_key_id

#### From here you can now run `terraform init` in the folder where you will be creating your scripts.

#### Run `terraform plan` to check the syntax and see what changes will be made.

#### Run `terraform apply` to apply the main.tf file and create the ec2 instance.

![image](https://user-images.githubusercontent.com/110126036/189125869-6e26cda7-41a9-4c58-ae84-f5523fa89b04.png)

#### You can also run `terraform destroy` to destroy the instance.

### Example Orchestration

```
resource "aws_instance" "app_instance" {

  # instance type
  instance_type = "t2.micro"

  # using which ami
  ami = data.aws_ami.ubuntu.id

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

resource "aws_instance" "database_instance" {

  # instance type
  instance_type = "t2.micro"

  # using which ami
  ami = data.aws_ami.ubuntu.id

  # how to name your instance
  tags = {
    Name = "eng122_samuel_terraform_db"
  }


  # how to attach your pem key to the app instance
  key_name = "eng122_sam_pem"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  subnet_id = aws_subnet.pub_subnet.id

  root_block_device {
    volume_size = 8
  }

}

resource "aws_instance" "controller_instance" {

  # instance type
  instance_type = "t2.micro"

  # using which ami
  ami = data.aws_ami.controller.id

  # how to name your instance
  tags = {
    Name = "eng122_samuel_ansible_controller"
  }


  # how to attach your pem key to the app instance
  key_name = "eng122_sam_pem"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  subnet_id = aws_subnet.pub_subnet.id

  root_block_device {
    volume_size = 8
  }

}


```

