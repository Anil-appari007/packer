packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
data "amazon-ami" "ubuntu-focal" {
  region = "us-east-1"
  filters = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "anils-packer-${formatdate("YYYY-MMM-DD-hh'hr'-mm'min'", "${timestamp()}")}" ## anils-packer-2022-Oct-01-17hr-05min

  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami = data.amazon-ami.ubuntu-focal.id    ##  ami-0c1704bac156af62c
  ssh_username = "ubuntu"
  tags = {
    Name        = "demo"
    environment = "production"
  }
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {

    inline = [
      "sudo apt-get clean",
      "echo updating",
      "sudo apt update",
      "echo Installing nginx",
      "sudo apt install -y nginx",
    ]
  }
}