variable "yandex_token" {
  type        = string
  description = "YandexCloud token"
}

variable "yandex_cloud_id" {
  type        = string
  description = "YandexCloud cloud id"
}
variable "yandex_folder_id" {
  type        = string
  description = "YandexCloud folder id"
}
variable "cloudflare_api_token" {
  type        = string
  description = "cloudflare api token"
}

variable "zone_name" {
  type        = string
  description = "main domain name"
}
variable "zone_suffix" {
  type        = string
  description = "additional suffix for uniqueness"
}
variable "node_name" {
  type        = string
  description = "node name"
}

variable "boot_disk_size" {
  type        = number
  description = "Boot disk size in gigabytes"
  default     = 10
}

variable "data_disk_size" {
  type        = number
  description = "Data disk size in gigabytes"
  default     = 10
}
variable "data_disk_type" {
  type        = string
  description = "network-hdd"
  default     = 10
}





variable "cores" {
  type        = number
  description = "Number of cores"
  default     = 2
}
variable "memory" {
  type        = number
  description = "Memory in Gigabytes"
  default     = 2

}
variable "os_image_family" {
  type        = string
  description = "os image famimly. (debian-11, centos-7, etc.) "
  default     = "debian-12"
}

variable "os_image_id" {
  type        = string
  description = "os image id. Run 'yc compute image list --folder-id standard-images' for list"
  default     = null
}




