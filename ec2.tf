resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.aws-linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.aws-sg.id]
  associate_public_ip_address = true
  key_name                    = "InfraDevOps-TechGenics"

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd

echo "<h1>Capstone Project 1 - Apache Running</h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "Capstone-WebServer"
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  value = aws_instance.web_server.public_dns
}