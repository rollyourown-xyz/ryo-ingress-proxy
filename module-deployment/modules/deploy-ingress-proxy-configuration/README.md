<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Deploy key-value pairs to consul KV store for providing ingress-proxy with configuration for ACLs, deny rules and use-backend rules

This module deploys key-value pairs to consul KV store for use by the ingress-proxy service. ACLs, deny rules and use-backend rules are specified by input variables:

## ingress-proxy_tcp_listeners (map of objects)

Map of TCP listener ports and services for haproxy TCP listener configuration. Each object must be a map. The object key is the TCP port for the listener and the object 'service' value is the name of the backend service to use. The form of the map is:

        number = {service = string}

## ingress-proxy_host_path_acls (map of objects)

Map of host/path ACLs for haproxy configuration. Each object must be a map. The object key is the ACL name, the object 'host' value is the ACL host and the object 'path' value is the ACL path. The form for a map is:

        acl_name = {host = string, path = string}

## ingress-proxy_path_only_acls (map of objects)

Map of path-only ACLs for haproxy configuration. Each object must be a map. The object key is the ACL name and the object 'path' value is the ACL path. The form for a map is:

        acl_name = {path = string}

## ingress-proxy_host_only_acls (map of objects)

Map of host-only ACLs for ingress-proxy configuration. Each object must be a map. The object key is the ACL name and the object 'host' value is the ACL host. The form for a map is:

        acl_name = {host = string}

## ingress-proxy_acl_denys (list of strings)

List of ACLs to use for http-request deny in haproxy configuration. Each list member is a string with the ACL name to use.

If the ACL is a host-only ACL, then the resulting haproxy HTTPS frontend deny rule is:

        http-request deny deny_status 403 if { hdr(host) -i <host> }

If the ACL is a host/path ACL, then the resulting haproxy HTTPS frontend deny rule is:

        http-request deny deny_status 403 if { hdr(host) -i <host> } { path_beg -i <path> }

## ingress-proxy_acl_use-backends (map of objects)

Map of ACLs to use for use-backend haproxy configuration. Each object must be a map. The object key is the ACL name, the object 'backend' value is the backend service to use. The form for a map is:

        acl_name = {backend_service = string}

If the ACL is a host-only ACL, then the resulting haproxy HTTPS frontend use-backend rule is:

        use_backend <backend_service> if { hdr(host) -i <host> }

If the ACL is a host/path ACL, then the resulting haproxy HTTPS frontend use-backend rule is:

        use_backend <backend_service> if { hdr(host) -i <host> } { path_beg -i <path> }
