# Output variable definitions

output "ingress-proxy_ip_address" {
    value       = lxd_container.ingress-proxy.ip_address
    description = "IP Address of the ingress-proxy container"
}
