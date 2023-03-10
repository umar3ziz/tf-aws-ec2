// ----------------------------------------------------------------------------
// Required Variables
// ----------------------------------------------------------------------------

variable "region" {
  type        = string
  description = "Region in which to deploy instances"
  default     = "eu-central-1"
}

variable "ami" {
  type        = string
  description = "Image ID"
  default     = "ami-0d1ddd83282187d18"
}

variable "key_name" {
  type        = string
  description = "key Pair"
  default     = "peter"
}

variable "instance_type" {
  type        = string
  description = "Instance Type"
  default     = "t3.micro"
}

variable "public_ip" {
  type        = bool
  description = "Associate Public IP Address"
  default     = true
}