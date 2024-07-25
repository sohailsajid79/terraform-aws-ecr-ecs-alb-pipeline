variable "region" {
  description = "AWS region"
  default     = "eu-north-1"
}

variable "ami" {
  description = "AMI ID"
  default     = "ami-07c8c1b18ca66bb07" # Canonical, Ubuntu, 24.04 LTS
}


variable "instance_type" {
  description = "Instance type"
  default     = "t3.micro"
}

variable "aws_key_pair" {
  description = "Name of the SSH key pair"
  default     = "ssh_key"
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  default     = "my-key-pair.pub"
}


