data "aws_ami" "ubuntu_ami" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}

resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu_ami.id
    instance_type = var.instance_size
   

    tags = {
        Name = "${var.instance_name}"
        ENV = "${var.env}"
    }
}