# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

terraform {
  required_version = ">= 0.15"
  required_providers {
    consul = {
      source = "hashicorp/consul"
      version = "~> 2.12.0"
    }
  }
}

## NOTE: TCP Listeners cannot currently be used as, although the ingress-proxy configuration
## is dynamically updated by consul-template, the ingress-proxy container itself does not have
## dynamically configured proxy devices.
resource "consul_keys" "tcp_listeners" {

  for_each = var.ingress-proxy_tcp_listeners

  # ACL for deny rule is set as key, no value is set
  key {
    path   = join("", [ "service/haproxy/tcp-listeners/", each.key ])
    value  = each.value["service"]
    delete = true
  }
}

resource "consul_keys" "host_path_acls" {

  for_each = var.ingress-proxy_host_path_acls

  # The folder for KVs is the ACL name, the host for the ACL is set as value for the key 'host'
  key {
    path   = join("", [ "service/haproxy/acl/", each.key, "/host" ])
    value  = each.value["host"]
    delete = true
  }
  
  # The folder for KVs is the ACL name, the path for the ACL is set as value for the key 'path'
  key {
    path   = join("", [ "service/haproxy/acl/", each.key, "/path" ])
    value  = each.value["path"]
    delete = true
  }
}

resource "consul_keys" "path_only_acls" {

  for_each = var.ingress-proxy_path_only_acls

  # The folder for KVs is the ACL name, the path for the ACL is set as value for the key 'path'
  key {
    path   = join("", [ "service/haproxy/acl/", each.key, "/path" ])
    value  = each.value["path"]
    delete = true
  }
}

resource "consul_keys" "host_only_acls" {

  for_each = var.ingress-proxy_host_only_acls

  # The folder for KVs is the ACL name, the host for the ACL is set as value for the key 'host'
  key {
    path   = join("", [ "service/haproxy/acl/", each.key, "/host" ])
    value  = each.value["host"]
    delete = true
  }
}

resource "consul_keys" "acl_denys" {

  for_each = toset(var.ingress-proxy_acl_denys)

  # ACL for deny rule is set as key, no value is set
  key {
    path   = join("", [ "service/haproxy/deny/", each.key ])
    value  = ""
    delete = true
  }
}

resource "consul_keys" "acl_redirects" {

  for_each = var.ingress-proxy_acl_redirects

  # ACL is set as key, redirect prefix is set as value
  key {
    path   = join("", [ "service/haproxy/redirect/", each.key ])
    value  = each.value["prefix"]
    delete = true
  }
}

resource "consul_keys" "acl_use-backends" {

  for_each = var.ingress-proxy_acl_use-backends

  # ACL is set as key, backend service is set as value
  key {
    path   = join("", [ "service/haproxy/use-backend/", each.key ])
    value  = each.value["backend_service"]
    delete = true
  }
}
