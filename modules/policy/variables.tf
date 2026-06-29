variable "policy_name" {
  type = string
}

variable "display_name" {
  type = string
}

variable "policy_rule" {
  description = "JSON-encoded policy rule"
  type        = string
}

variable "subscription_id" {
  type = string
}