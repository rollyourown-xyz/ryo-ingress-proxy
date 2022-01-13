# Deploy Ingress Proxy for rollyourown.xyz modules and projects
###############################################################

resource "lxd_container" "ingress-proxy" {

  remote     = var.host_id
  name       = "ingress-proxy"
  image      = join("-", [ local.module_id, "ingress-proxy", var.image_version ])
  profiles   = ["default"]
  
  config = { 
    "security.privileged": "false"
    "user.user-data" = file("cloud-init/cloud-init-basic.yml")
  }
  
  ## Provide eth0 interface with static IP address
  device {
    name = "eth0"
    type = "nic"

    properties = {
      name           = "eth0"
      network        = var.host_id
      "ipv4.address" = join(".", [ local.lxd_host_network_part, local.ingress-proxy_ip_addr_host_part ])
    }
  }
  
  ## Add proxy devices for the module

  ### HTTP Port 80
  device {
    name = "proxy0"
    type = "proxy"

    properties = {
      listen  = join("", [ "tcp:", local.lxd_host_control_ipv4_address, ":80" ] )
      connect = join("", [ "tcp:", local.lxd_host_network_part, ".", local.ingress-proxy_ip_addr_host_part, ":80" ] )
      nat     = "yes"
    }
  }

  ### HTTPS Port 443
  device {
    name = "proxy1"
    type = "proxy"

    properties = {
      listen  = join("", [ "tcp:", local.lxd_host_control_ipv4_address, ":443" ] )
      connect = join("", [ "tcp:", local.lxd_host_network_part, ".", local.ingress-proxy_ip_addr_host_part, ":443" ] )
      nat     = "yes"
    }
  }

  ## Mount container directories for persistent storage for the module

  ### Directory for certbot configuration data
  device {
    name = "certbot-data"
    type = "disk"
    
    properties = {
      source   = join("", ["/var/containers/", local.module_id, "/ingress-proxy/certbot"])
      path     = "/etc/letsencrypt"
      readonly = "false"
      shift    = "true"
    }
  }

  ### Directory for concatenated letsencrypt certificates (used by HAProxy)
  device {
    name = "concat-certs"
    type = "disk"
    
    properties = {
      source   = join("", ["/var/containers/", local.module_id, "/ingress-proxy/tls/concatenated"])
      path     = "/etc/haproxy/ssl"
      readonly = "false"
      shift    = "true"
    }
  }

  ### Directory for non-concatenated letsencrypt certificates (used by other containers)
  device {
    name = "non-concat-certs"
    type = "disk"
    
    properties = {
      source   = join("", ["/var/containers/", local.module_id, "/ingress-proxy/tls/non-concatenated"])
      path     = "/var/certs"
      readonly = "false"
      shift    = "true"
    }
  }
}