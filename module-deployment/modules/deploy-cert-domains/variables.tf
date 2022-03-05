# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Input variable definitions

variable "certificate_domains" {
  description = "Map of domains to request letsencrypt certificates. Each list member must be a map of domain and admin email for the certificate request."
  type = map(object({
    domain      = string
    admin_email = string
  }))
}