
fingerprint = "83:51:bb:43:e1:ff:40:32:00:aa:78:1c:88:a1:ad:22"

tenacy_ocid = "ocid1.tenancy.oc1..aaaaaaaagkbzgg6lpzrf47xzy4rjoxg4de6ncfiq2rncmjiujvy2hjgxvziq"

user_ocid = "ocid1.user.oc1..aaaaaaaasqsrll5dmaoswjahlem2mgslwujfp23m2o2ntiadafettb2hh74a"

region = "us-phoenix-1"

k8s_compartment = "ocid1.compartment.oc1..aaaaaaaaqvic2rwmnjwz4jnpivip5falzfycgsjzwpvudemmmlavozitavwa"

vcn_info = {
  name = "k8s_vcn1"
  cidr_blocks = ["10.0.0.0/16"]
  dns_label = "k8svcn"
}

igw_info = {
    name = "k8s_igw"
    enabled = true
}

ngw_info = {
    name = "k8s_ngw"
    block_traffic = false
}

sgw_info = {
    name = "k8s_sgw"
    #block_traffic = false
}

route_table_api_info = {
  name = "routetable_api"
  route_rule = {
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

route_table_worker_info = {
  name = "routetable_worker"
  route_rule = {
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
  route_rule2 = {
    #destination = "0.0.0.0/0"
    destination_type = "SERVICE_CIDR_BLOCK"
  }
}

route_table_lb_info = {
  name = "routetable_lb"
  route_rule = {
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

security_list_api_info = {
  name = "securitylist_api"
}

security_list_worker_info = {
  name = "securitylist_worker"
}

security_list_lb_info = {
  name = "securitylist_lb"
}

subnet_api_info = {
  name = "api_subnet"
  CIDR = "10.0.0.0/30"
  dns_label = "apisubnet"
}

subnet_worker_info = {
  name = "worker_subnet"
  CIDR = "10.0.1.0/24"
  dns_label = "workersubnet"
}

subnet_lb_info = {
  name = "lb_subnet"
  CIDR = "10.0.2.0/24"
  dns_label = "lbsubnet"
}

ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5Iy63EdBHRevC/uMzczy+whnvnCSd9Z6Hg09eqbGLkz0od6PYsFCbjim5Bkx/ZnhAhN4uUwUcVpUph3dACX1sDL3e5E/rb0nc9kYj3saEw2UOzU2VKQh0T6SRP7dShwlSuOARFMsj3VJDefvvIwJYXoCaQp8kTgo8Kv36dhzK8ClAP1SM6fzvMQHBg9Z3IN9q6tK+NktdFs7FlbVViSG+jGjDkflsF8LMjYNMQxC0K8TRtzBHhfTR9kuusnJI6Z0GB98KlcKMPnbHafFcKcIPCZL6FLGcm17UaR8CubhGYmy3ZqMShRtAdyzPLBzhIhMRJ/CkNxvprtcTF/iJnslX sshkeyname"

