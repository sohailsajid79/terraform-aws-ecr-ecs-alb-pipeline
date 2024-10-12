variable "region" {
  description = "AWS region"
  default     = "eu-north-1"
}

variable "cloudflare_email" {
  description = "Email address for Cloudflare account"
  sensitive   = true

}

variable "cloudflare_api_key" {
  description = "API key for Cloudflare account"
  sensitive   = true

}
