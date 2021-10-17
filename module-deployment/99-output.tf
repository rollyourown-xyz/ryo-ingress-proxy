# Output variable definitions

output "haproxy_ip_address" {
    value       = lxd_container.haproxy.ip_address
    description = "IP Address of the haproxy container"
}
