variable "brand" {
  description = "Brand name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
}

variable "storage_subnet_prefix" {
  description = "Address prefix for the storage subnet"
  type        = string
}

variable "private_endpoints_subnet_prefix" {
  description = "Address prefix for the private endpoints subnet"
  type        = string
}

variable "aks_subnet_prefix" {
  description = "Address prefix for the AKS subnet"
  type        = string
}