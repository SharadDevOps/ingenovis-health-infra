variable "name" {
  description = "Name of the resource group. Set in main.tf."
  type        = string
}

variable "location" {
  description = "Location of the resource group. Set in main.tf."
  type        = string
}

variable "brand" {
  description = "Deployment brand. Set in main.tf."
  type        = string
}   

variable "environment" {
  description = "Deployment environment. Set in main.tf."
  type        = string
}