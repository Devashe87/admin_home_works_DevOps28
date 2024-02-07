  variable "resousrce_instance_minimal_web" {
  type        = list(object({
    vm_name = string
    platform_id = string
    count = number
    cores = number
    memory = number
    core_fraction = number
    zone = string
  }))

  default = [{
      vm_name = "web"
      platform_id = "standard-v1"
      count         = 2
      cores         = 2
      memory        = 1
      core_fraction = 5
      zone = "ru-central1-a"
    }]
}

resource "yandex_compute_instance" "web" {
    name = "${var.resousrce_instance_minimal_web[0].vm_name}-${count.index+1}"
    platform_id = var.resousrce_instance_minimal_web[0].platform_id

    count = var.resousrce_instance_minimal_web[0].count

    resources {
        cores = var.resousrce_instance_minimal_web[0].cores
        memory = var.resousrce_instance_minimal_web[0].memory
        core_fraction = var.resousrce_instance_minimal_web[0].core_fraction
        }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
        }
    }

    metadata = {
        ssh-keys = "ubuntu:${local.ssh-keys}"
        serial-port-enable = "1"
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = true
        security_group_ids = [
            yandex_vpc_security_group.example.id
        ]
    }
    scheduling_policy {
        preemptible = true
    }
}