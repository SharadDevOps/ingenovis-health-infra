variable "github_owner" {
  description = "GitHub username"
  type        = string
}

variable "github_repository" {
  description = "GitHub repo name for the application manifests"
  type        = string
}

variable "github_token" {
  description = "GitHub PAT with repo scope"
  type        = string
  sensitive   = true
}