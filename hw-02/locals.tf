locals {
  vm_web_instance_name = "netology-${var.env}-${var.project}-${var.role[0]}"
  vm_db_instance_name = "netology-${var.env}-${var.project}-${var.role[1]}"
}
