variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for subnet"
  default     = "us-west-2a"
}

variable "my_ip" {
  type        = string
  description = "Public IP allowed for SSH"
}

variable "key_name" {
  type        = string
  description = "Existing AWS key pair name"
}
