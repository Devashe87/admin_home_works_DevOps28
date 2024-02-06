output "vm_external_ip" {
  value = {
    instance_name1   = yandex_compute_instance.platform.name
    fqdn             = yandex_compute_instance.platform.fqdn
    vm_external_ip1  = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    instance_name2   = yandex_compute_instance.platform2.name
    fqdn2             = yandex_compute_instance.platform2.fqdn
    vm_external_ip2  = yandex_compute_instance.platform2.network_interface.0.nat_ip_address
  }
}
