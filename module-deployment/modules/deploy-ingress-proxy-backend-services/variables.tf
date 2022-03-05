# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Input variable definitions

variable "ssl_backend_services" {
  description = "List of SSL backend services to configure."
  type = list(string)
  default = []
}

variable "non_ssl_backend_services" {
  description = "List of non-SSL backend services to configure."
  type = list(string)
  default = []
}
