variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the Azure Container Registry"
  type        = string
}

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
}

variable "tags" {
  description = "The tags for the Azure Container Registry"
  type        = map(string)
}

variable "brand" {
  description = "The brand for the Azure Container Registry"
  type        = string
}

variable "environment" {
  description = "The environment for the Azure Container Registry"
  type        = string
}