// Define subnets and VPC CIDR for network module to provision application environment

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "worker_ami" {
  type = string
}

variable "subnets" {
    default = [
    {
      az     = "us-east-2a",
      prefix = "10.1.1.0/24"
    },
    {
      az     = "us-east-2b",
      prefix = "10.1.2.0/24"
    },
    {
      az     = "us-east-2c",
      prefix = "10.1.3.0/24"
    }
  ]
}

variable "application_name" {
  type = string
}

variable "application_version" {
  type = string
}

variable "artifact_bucket" {
  type = string
}

variable "frontend_port" {
  default = "80"
}

variable "backend_port" {
  default = 8000
}

variable "autoscaling" {
  default = {
    min = 2
    max = 4
    desired = 2
  }
}