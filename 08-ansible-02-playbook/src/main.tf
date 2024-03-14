locals {
  ssh-keys = file("~/.ssh/centos7.pub")
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "centos7" {
  family = var.vm_centos7
}
resource "yandex_compute_instance" "platform" {
  name        = "clichhouse-01"
  platform_id = var.vm_platform_id
  #metadata = var.common_metadata
  resources {
    cores         = 2
    memory        = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos7.image_id
    }
  }
  
  metadata = {
  ssh-keys = "centos:${local.ssh-keys}"
  serial-port-enable = "1"
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
}