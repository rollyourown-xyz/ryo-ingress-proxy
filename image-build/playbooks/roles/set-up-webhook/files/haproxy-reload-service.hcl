# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

service {
  name = "haproxy-reload-webhook"
  tags = [ "loadbalancer", "tls_proxy" ]
  port = 9000
}
