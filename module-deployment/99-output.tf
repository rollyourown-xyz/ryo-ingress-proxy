# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Output variable definitions

output "ingress-proxy_ipv4_address" {
    value       = lxd_container.ingress-proxy.ipv4_address
    description = "IPv4 Address of the ingress-proxy container"
}

#
# THE FOLLOWING IS EXPERIMENTAL
output "ingress-proxy_ipv6_address" {
    value       = lxd_container.ingress-proxy.ipv6_address
    description = "IPv6 Address of the ingress-proxy container"
}
# END EXPERIMENTAL
#
