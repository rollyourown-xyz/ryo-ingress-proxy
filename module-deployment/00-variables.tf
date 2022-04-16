# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Input Variables
#################

variable "host_id" {
  description = "Mandatory: The host_id on which to deploy the module."
  type        = string
}

variable "image_version" {
  description = "Version of the images to deploy - Leave blank for 'terraform destroy'"
  type        = string
}

# Local variables
#################

# Configuration file paths
locals {
  module_configuration = "${abspath(path.root)}/../configuration/configuration.yml"
  host_configuration   = join("", ["${abspath(path.root)}/../../ryo-host/configuration/configuration_", var.host_id, ".yml" ])
}

# Basic module variables
locals {
  module_id                       = yamldecode(file(local.module_configuration))["module_id"]
  ingress_proxy_ip_addr_host_part = yamldecode(file(local.module_configuration))["ingress_proxy_ip_addr_host_part"]
  host_public_ipv6                = yamldecode(file(local.module_configuration))["host_public_ipv6"]
}

# LXD variables
locals {
  lxd_host_control_ipv4_address = yamldecode(file(local.host_configuration))["host_control_ip"]
  lxd_host_network_part         = yamldecode(file(local.host_configuration))["lxd_host_network_part"]
  lxd_host_public_ipv6_address  = yamldecode(file(local.host_configuration))["host_public_ipv6_address"]
  lxd_host_public_ipv6_prefix   = yamldecode(file(local.host_configuration))["host_public_ipv6_prefix"]
  lxd_host_private_ipv6_prefix  = yamldecode(file(local.host_configuration))["lxd_host_private_ipv6_prefix"]
  lxd_host_network_ipv6_subnet  = yamldecode(file(local.host_configuration))["lxd_host_network_ipv6_subnet"]
}
