# An Amazon Machine Image (AMI) is a supported and maintained image provided by AWS that provides the information required to launch an instance.

provider "aws" {
  region = "us-east-1"  # replace for region that  you want
}


# In Terraform, data does not refer to a variable in the traditional sense. 
# In Terraform, the data block is used to query and retrieve existing information
# from AWS or other providers before creating or modifying resources.
# It is not a variable in the sense of a location to store values but
#rather a mechanism to retrieve specific data.

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
}




