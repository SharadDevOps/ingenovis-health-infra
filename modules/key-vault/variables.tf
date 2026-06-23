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
  description = "Subnet ID where the Key Vault's private endpoint will be created"
  type        = string
}

variable "uami_principal_id" {
  description = "Principal ID (object ID) of the environment's UAMI - gets Key Vault Secrets User role"
  type        = string
}
