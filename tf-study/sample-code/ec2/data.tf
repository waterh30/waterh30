# get ami
data "aws_ami" "std_ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }
}