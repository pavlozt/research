terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  token       = var.yandex_token
  cloud_id    = var.yandex_cloud_id
  folder_id   = var.yandex_folder_id
  zone        = "ru-central1-a"
  max_retries = 3
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
