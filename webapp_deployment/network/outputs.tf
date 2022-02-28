output "subnet_ids" {
  value = [
    for i, subnet in aws_subnet.public_subnets :
    { subnet_id = subnet.id, subnet_az = subnet.availability_zone }
  ]
}


output "vpc_id" {
  value = aws_vpc.web_app_vpc.id
}