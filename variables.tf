variable "subscription_id" {}
variable "client_id" {}
variable  "client_secret" {}
variable "tenant_id" {}
variable "version" {}

variable "name" {}
variable "location" {}
variable "owner" {}

variable "name_vnet" {}
variable "address_space" {
  type = "list"
}
variable "vmSize" {}

variable "key_data" {}
