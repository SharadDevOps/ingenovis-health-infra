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
  description = "Resource group this identity lives in"
  type        = string
}

variable "resource_group_id" {
  description = "Full resource ID of the resource group, used to scope the role assignment to this RG only - never the subscription"
  type        = string
}
