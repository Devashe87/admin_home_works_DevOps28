# variable "common_metadata" {
#   description = "metadata for all vms"
#   type        = map(string)
#   default     = {
#     serial-port-enable = "1"
#     ssh-keys          = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjg5R2DrI4nddLRy7JQCJ0iI7eeFUdmsMPQCTD11eS6 devashe@Devashe87.local"
#   }
# }

variable "vm_centos7" {
  type = string
  default = "centos-7"
  description = "Os version"
}

variable "vm_platform_id" {
  type = string
  default = "standard-v3"
  description = "platform ID"
}