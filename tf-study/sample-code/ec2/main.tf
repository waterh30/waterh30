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
    vpc_security_group_ids = [aws_security_group.web-server.id]
    user_data = <<-EOF
      #!/bin/bash
      yum -y install httpd
      echo "<h1>Hello, World<h1>" > /var/www/html/index.html
      sudo systemctl enable http
      sudo systemctl start http
      EOF

    tags = {
        Name = "myInstance"
    }

}

resource "aws_security_group" "web-server" {
    name = "myInstance"
    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "web sg"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    } 
}

output "DNS" {
    value = aws_instance.myInstance.public_dns
}