data "cloudflare_zone" "cf_zone" {
  name = var.zone_name
}

resource "cloudflare_record" "node" {
  name    = "${var.node_name}.${var.zone_suffix}"
  zone_id = data.cloudflare_zone.cf_zone.zone_id
  value   = yandex_compute_instance.vm.network_interface[0].nat_ip_address
  type    = "A"
  ttl     = 60
  proxied = "false"
}


