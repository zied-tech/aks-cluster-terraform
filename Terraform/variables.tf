variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}
variable "name" {
  description = "Azure Kubernetes Resource Group"
  type = string
  default = "k8s-rg"
}
variable "location" {
  description = "Azure Kubernetes Resource Group location"
  type = string
}
