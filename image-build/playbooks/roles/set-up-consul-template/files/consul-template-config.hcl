consul {
  address = "127.0.0.1:8500"
  
  auth {
    enabled = false
  }
  
  retry {
    enabled  = true
    attempts = 0
    backoff = "250ms"
    max_backoff = "1m"
  }
}

# Template for dynamic certbot initialisation based on consul key-values
template {
  source = "/etc/consul-template/certbot-initialise.ctmpl"
  destination = "/usr/local/bin/certbot-initialise.sh"
  command = "/usr/local/bin/certbot-initialise.sh"
  wait {
    min = "2s"
    max = "10s"
  }
}

# Template for dynamic cert deployment script based on consul key-values
template {
  source = "/etc/consul-template/cert-deploy.ctmpl"
  destination = "/usr/local/bin/cert-deploy.sh"
  command = "/usr/local/bin/certbot-initialise.sh"
  wait {
    min = "2s"
    max = "10s"
  }
}

# Template for dynamic iptables configuration based on consul key-values
template {
  source = "/etc/consul-template/iptables-rules.ctmpl"
  destination = "/usr/local/bin/iptables-rules.sh"
  command = "/usr/local/bin/iptables-rules.sh"
  wait {
    min = "2s"
    max = "10s"
  }
}

# Template for dynamic haproxy configuration based on consul key-values and service discovery
template {
  source = "/etc/consul-template/haproxy.ctmpl"
  destination = "/etc/haproxy/haproxy.cfg"
  command = "/usr/local/bin/reload-haproxy.sh"
  wait {
    min = "2s"
    max = "10s"
  }
}