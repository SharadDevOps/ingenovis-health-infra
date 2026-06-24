variable "location" {
  description = "The location of the Azure Container Registry"
  type        = string
  
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}


variable "brand" {
  description = "The brand for the Azure Container Registry"
  type        = string
}

variable "environment" {
  description = "The environment for the Azure Container Registry"
  type        = string
}

variable "private_endpoints_subnet_id" {
  description = "Subnet ID where the Cosmos db's private endpoint will be created"
  type        = string
}

variable "aks_subnet_id" {
  description = "The subnet ID for the AKS cluster"
  type        = string
}

variable "uami_id" {
  description = "The user-assigned managed identity ID for the AKS cluster"
  type        = string
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry"
  type        = string
}
