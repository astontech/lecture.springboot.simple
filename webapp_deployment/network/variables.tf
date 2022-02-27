variable "application_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = list(map(string))
}

