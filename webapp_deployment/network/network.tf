resource "aws_vpc" "web_app_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Environment = var.application_name
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = {
    for index, subnet in var.subnets :
    subnet.az => subnet
  }
  vpc_id            = aws_vpc.web_app_vpc.id
  cidr_block        = each.value.prefix
  availability_zone = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Environment = var.application_name
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.web_app_vpc.id

  tags = {
    Environment = var.application_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.web_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Environment = var.application_name
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

