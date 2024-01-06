resource "yandex_compute_instance" "vm" {
  name     = var.node_name
  hostname = var.node_name
  resources {
    cores  = var.cores
    memory = var.memory
    #core_fraction = 20
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    ssh-keys  = "root:${file("~/.ssh/id_rsa.pub")}"
    user-data = <<-EOT
    #cloud-config
    # dirty hack if drive not ready
    bootcmd:
      - while [ ! -b /dev/vdb ]; do echo 'Waiting for device ...'; sleep 1; done
    fs_setup:
      - label: data,
        filesystem: ext4
        device: /dev/vdb
        partition: auto
    mounts:
      - [ /dev/vdb, /data/, auto, "defaults,noexec" ]
    EOT
  }
  boot_disk {
    initialize_params {
      # image_id = try(var.os_image_id, data.yandex_compute_image.myosimage.id)
      image_id = var.os_image_id != null ? var.os_image_id : data.yandex_compute_image.myosimage.id
      size     = var.boot_disk_size
    }
  }
  secondary_disk {
    disk_id = yandex_compute_disk.datadisk.id
  }
  network_interface {
    nat       = true
    subnet_id = data.yandex_vpc_subnet.default_subnet.id
  }
  allow_stopping_for_update = true

  provisioner "local-exec" {
    command = "cd ../ansible; ansible-playbook -e 'ansible_user=${local.ssh_username}' -i ${yandex_compute_instance.vm.network_interface[0].nat_ip_address}, docker_playbook.yml tools_playbook.yml"
  }
}

resource "yandex_compute_disk" "datadisk" {
  type = var.data_disk_type
  size = var.data_disk_size
}

data "yandex_compute_image" "myosimage" {
  family = var.os_image_family
}


data "yandex_vpc_network" "default_network" {
  name = "default"
}

data "yandex_vpc_subnet" "default_subnet" {
  name = "default-ru-central1-a"
}


locals {
  fqdn         = "${var.node_name}.${var.zone_suffix}.${var.zone_name}"
  ssh_username = element(split("-", var.os_image_family), 0) // using first element as os login
}


