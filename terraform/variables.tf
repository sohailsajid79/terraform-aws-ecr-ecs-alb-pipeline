variable "region" {
  description = "AWS region"
  default     = "eu-north-1"
}

variable "image_tag" {
  description = "The tag of the Docker image to deploy"
  default     = "latest"
}