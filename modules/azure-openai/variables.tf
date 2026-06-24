variable "brand" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "private_endpoints_subnet_id" {
  description = "Subnet ID where the OpenAIs private endpoint will be created"
  type        = string
}
