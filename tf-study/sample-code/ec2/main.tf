# provider aws {
#     region = "us-east-1"
# }

# data "aws_ami" "std_ami" {
#     most_recent = true
#     owners = ["amazon"]

#     filter {
#       name = "root-device-type"
#       values = ["ebs"]
#     }
#     filter {
#       name   = "virtualization-type"
#       values = ["hvm"]
#     }
# }

resource "aws_instance" "myInstance" {
    ami = data.aws_ami.std_ami.id
    instance_type = "t2.micro"

    tags = {
        Name = "myInstance"
    }

}

