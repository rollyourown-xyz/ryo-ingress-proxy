# Deploy Consul Service Registry and Key-Value Store for rollyourown.xyz modules and projects
#############################################################################################

resource "lxd_container" "consul" {
  remote     = var.host_id
  name       = join("-", [ var.host_id, local.module_id, "consul" ])
  image      = join("-", [ local.module_id, "consul", var.image_version ])
  profiles   = ["default"]
  
  config = { 
    "security.privileged": "false"
    "user.user-data" = file("cloud-init/cloud-init-basic.yml")
  }
  
  # Provide eth0 interface with static IP address
  device {
    name = "eth0"
    type = "nic"

    properties = {
      name           = "eth0"
      network        = "lxdbr0"
      "ipv4.address" = join(".", [ local.lxd_br0_network_part, "10" ])
    }
  }
  
  # Mount container directory for persistent storage for the module
  device {
    name = "consul-data"
    type = "disk"
    
    properties = {
      source   = join("", ["/var/containers/", local.module_id, "/consul/data"])
      path     = "/var/consul"
      readonly = "false"
      shift    = "true"
    }
  }
}
