# Input variable definitions

variable "ingress-proxy_tcp_listeners" {
  description = "Map of TCP Listeners to use in ingress-proxy configuration."
  type = map(object({
    service = string
  }))
  default = {}
}

variable "ingress-proxy_host_path_acls" {
  description = "Map of host/path ACLs for ingress-proxy configuration."
  type = map(object({
    host = string
    path = string
  }))
  default = {}
}

variable "ingress-proxy_path_only_acls" {
  description = "Map of path-only ACLs for ingress-proxy configuration."
  type = map(object({
    path = string
  }))
  default = {}
}

variable "ingress-proxy_host_only_acls" {
  description = "Map of host-only ACLs for ingress-proxy configuration."
  type = map(object({
    host = string
  }))
  default = {}
}

variable "ingress-proxy_acl_denys" {
  description = "List of ACLs to use for http-request deny in ingress-proxy configuration."
  type = list(string)
  default = []
}

variable "ingress-proxy_acl_use-backends" {
  description = "Map of ACLs to use for use-backend ingress-proxy configuration."
  type = map(object({
    backend_service = string
  }))
  default = {}
}
