variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-south-1"
}

variable "image_id" {
  description = "AMI Id will be used for auto scaling group "
}

variable "availability_zones" {
  default     = "eu-south-1a,eu-south-1b,eu-south-1c"
  description = "List of availability zones, use AWS CLI to find your "
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}
