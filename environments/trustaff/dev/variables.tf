variable "brand" {
  description = "Deployment brand. Set in terraform.tfvars."
  type        = string
}

variable "environment" {
  description = "Deployment environment. Set in terraform.tfvars."
  type        = string
}

variable "location" {
  description = "Location name. Set in terraform.tfvars."
  type        = string
}

variable "vnet_address_space" {
  description = "Virtual network address space. Set in terraform.tfvars."
  type        = string
}

variable "aks_subnet_prefix" {
  description = "AKS subnet prefix. Set in terraform.tfvars."
  type        = string
}

variable "storage_subnet_prefix" {
  description = "Storage subnet prefix. Set in terraform.tfvars."
  type        = string
}


variable "private_endpoints_subnet_prefix" {
  description = "Private endpoints subnet prefix. Set in terraform.tfvars."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "client_id" {
  description = "Azure client ID (App Registration)"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "client_secret" {
  description = "Azure client secret (App Registration)"
  type        = string
  sensitive   = true
}

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}