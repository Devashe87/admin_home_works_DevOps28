variable "vms_resources" {
  description = "Resources for all vms"
  type        = map(map(number))
  default     = {
    vm_web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    vm_db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "common_metadata" {
  description = "metadata for all vms"
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys          = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjg5R2DrI4nddLRy7JQCJ0iI7eeFUdmsMPQCTD11eS6 devashe@Devashe87.local"
  }
}

variable "vm_web_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "Os version"
}

# variable "vm_web_name" {
#   type = string
#   default = "netology-develop-platform-web"
#   description = "vm web name"
# }

variable "vm_web_platform_id" {
  type = string
  default = "standard-v1"
  description = "platform ID"
}

# variable "vm_web_cores" {
#   type = string
#   default = "2"
#   description = "cores"
# }

# variable "vm_web_memory" {
#   type = string
#   default = "1"
#   description = "vm_web memory gb"
# }

# variable "vm_web_core_fraction" {
#   type = string
#   default = "5"
#   description = "vm_web_core_fraction"
# }

variable "vm_db_family" {
  type = string
  default = "ubuntu-2004-lts"
  description = "Os version"
}

# variable "vm_db_name" {
#   type = string
#   default = "netology-develop-platform-db"
#   description = "vm web name"
# }

variable "vm_db_platform_id" {
  type = string
  default = "standard-v1"
  description = "platform ID"
}

# variable "vm_db_cores" {
#   type = string
#   default = "2"
#   description = "cores"
# }

# variable "vm_db_memory" {
#   type = string
#   default = "2"
#   description = "vm_web memory gb"
# }

# variable "vm_db_core_fraction" {
#   type = string
#   default = "20"
#   description = "vm_web_core_fraction"
# }