# The terraform lxd provider is required to deploy this module
##############################################################

terraform {
  required_version = ">= 0.14"

  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "~> 1.5.0"
    }
  }
}

provider "lxd" {

  config_dir                   = "$HOME/snap/lxd/current/.config/lxc"
  generate_client_certificates = false
  accept_remote_certificate    = false

  lxd_remote {
    name     = var.host_id
    default  = true
  }
}
