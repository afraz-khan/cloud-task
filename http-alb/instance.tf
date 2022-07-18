resource "aws_instance" "web-server" {
  ami           = "ami-01cc34ab2709337aa"
  instance_type = "t2.micro"
	count = 2
	key_name = "cda"
	security_groups = ["${aws_security_group.web-server.name}"]
	user_data = <<-EOF

		#!/bin/bash

		sudo su
		yum update -y
		yum install -y httpd

		systemctl start httpd
		systemctl enable httpd

		echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
		EOF

	tags = {
		Name: "instance-${count.index}"
	}
}