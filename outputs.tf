
output "vpc_id" {
  value = aws_vpc.tf-vpc.id
}

output "public_subnet" {
  value = aws_subnet.tf-subnet.id
}

output "ec2_public_ip" {
  value = aws_instance.tf-instance.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.tf-instance.public_dns
}