Installation

$ wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
$ echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
$ sudo apt update && sudo apt install packer


Initialize
$ packer init aws-ami-nginx.pkr.hcl

Validate
$ packer validate aws-ami-nginx.pkr.hcl

Build image
$ packer build aws-ami-nginx.pkr.hcl