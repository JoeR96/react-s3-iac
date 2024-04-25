variable "domain_name" {
  description = "The domain name for the website"
  type        = string
}

variable "env" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}
