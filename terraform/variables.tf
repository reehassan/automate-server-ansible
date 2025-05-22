variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "public_key_path" {
  description = "Path to your public SSH key file"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP address in CIDR notation for SSH access"
  type        = string
}
