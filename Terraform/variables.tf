variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "node_resource_group" {
  type        = string
  description = "RG name for cluster resources in Azure"
}
variable "system_node_count" {
  type        = string
  description = "Node Count of AKS Cluster"
}



variable "sp_subscription_id" {
  type        = string
}
variable "sp_client_id" {
  type        = string
}
variable "sp_client_secret" {
  type        = string
}
variable "sp_tenant_id" {
  type        = string

}