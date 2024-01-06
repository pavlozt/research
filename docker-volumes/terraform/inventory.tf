resource "local_file" "ansible_hosts_file" {
  filename = "../ansible/hosts/inventory.yaml"
  content = templatefile("${path.module}/ansible-hosts.tpl", {
    ips          = yandex_compute_instance.vm[*].network_interface[0].nat_ip_address
    dnsname      = local.fqdn
    ssh_username = local.ssh_username
  })
  file_permission = 0644
}



