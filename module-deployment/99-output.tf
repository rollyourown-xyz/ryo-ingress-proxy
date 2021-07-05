# Output variable definitions

output "consul_ip_address" {
    value       = lxd_container.consul.ip_address
    description = "IP Address of the consul container"
}

output "haproxy_ip_address" {
    value       = lxd_container.haproxy.ip_address
    description = "IP Address of the haproxy container"
}
