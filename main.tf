resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./key.pem; chmod 400 ./key.pem"
  }
}

resource "aws_vpc" "tf-vpc" {
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
}

resource "aws_subnet" "tf-subnet" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "172.31.16.0/20"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1a"

}
resource "aws_security_group" "tf-sg" {
  name = "tf-sg"
  description = "Terraform Security Group"
  vpc_id = aws_vpc.tf-vpc.id

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  // To Allow SSH Outbound
  egress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "tf-instance" {
  depends_on = [ aws_security_group.tf-sg ]

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.tf-subnet.id
  associate_public_ip_address = var.public_ip
  key_name                    = aws_key_pair.key_pair.id

  vpc_security_group_ids = [
    aws_security_group.tf-sg.id
  ]

  tags = {
    Name ="Peter"
    Environment = "DEV"
    OS = "UBUNTU"
  }

}
