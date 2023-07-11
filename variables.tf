variable "user_ocid" {
    description = "User ocid"
    type = string
}

variable "tenacy_ocid"  {
    description = "Tenacy ocid"
    type = string
}

variable "region"  {
    description = "Region where you have tenacy"
    type = string
}

variable "fingerprint"  {
    description = "Fingerprint"
    type = string
}

variable "k8s_compartment"  {
    description = "OCID of compartment"
    type = string
}

variable "vcn_info"  {
    description = "Information about vcn"
    type = object({
      name = string
      cidr_blocks = list(string)
      dns_label = string
    })
}

variable "igw_info" {
    description = "Information about internet gateway"
    type = object({
      name = string
      enabled = bool
    })
}

variable "ngw_info"  {
    description = "Information about NAT gateway"
    type = object({
      name = string
      block_traffic = bool
    })
}

variable "sgw_info"  {
    description = "Information about Service gateway"
    type = object({
      name = string
      #block_traffic = bool
    })
}

variable "route_table_api_info"  {
    description = "Information about route table for API Endpoint subnet"
    type = object({
      name = string
      route_rule = object({
        destination = string
        destination_type = string
      })
    })
}

variable "route_table_worker_info"  {
    description = "Information about route table for Worker subnet"
    type = object({
      name = string
      route_rule = object({
        destination = string
        destination_type = string
      })
      route_rule2 = object({
        #destination = string
        destination_type = string
      })
    })
}

variable "route_table_lb_info"  {
    description = "Information about route table for API Endpoint subnet"
    type = object({
      name = string
      route_rule = object({
        destination = string
        destination_type = string
      })
    })
}

variable "security_list_api_info"  {
    description = "Information about security list for API Endpoint subnet"
    type = object({
      name = string
    })
}

variable "security_list_worker_info"  {
    description = "Information about security list for worker node subnet"
    type = object({
      name = string
    })
}

variable "security_list_lb_info"  {
    description = "Information about security list for lb subnet"
    type = object({
      name = string
    })
}

variable "subnet_api_info"  {
    description = "Information about subnet for API Endpoint"
    type = object({
      name = string
      CIDR = string
      dns_label = string
    })
}

variable "subnet_worker_info"  {
    description = "Information about subnet for worker nodes"
    type = object({
      name = string
      CIDR = string
      dns_label = string
    })
}

variable "subnet_lb_info"  {
    description = "Information about subnet for worker nodes"
    type = object({
      name = string
      CIDR = string
      dns_label = string
    })
}


variable "cluster_name" {
  type = string
  default = "k8s-Cluster-tf"
}

variable "node_pool_name" {
  type = string
  default = "node-pool"
}

variable "node_pool_image_id"  {
  type = string
  default = "ocid1.image.oc1.phx.aaaaaaaa62dypq5adag3q74fhhw2gwlevums5kzfvdomc5tojdfqqyinct7q"
}

variable "node_pool_node_shape" {
  type = string
  default = "VM.Standard.E4.Flex"
}

variable "ssh_key"  {
    description = "Information of the image of the instance"
    type = string
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5Iy63EdBHRevC/uMzczy+whnvnCSd9Z6Hg09eqbGLkz0od6PYsFCbjim5Bkx/ZnhAhN4uUwUcVpUph3dACX1sDL3e5E/rb0nc9kYj3saEw2UOzU2VKQh0T6SRP7dShwlSuOARFMsj3VJDefvvIwJYXoCaQp8kTgo8Kv36dhzK8ClAP1SM6fzvMQHBg9Z3IN9q6tK+NktdFs7FlbVViSG+jGjDkflsF8LMjYNMQxC0K8TRtzBHhfTR9kuusnJI6Z0GB98KlcKMPnbHafFcKcIPCZL6FLGcm17UaR8CubhGYmy3ZqMShRtAdyzPLBzhIhMRJ/CkNxvprtcTF/iJnslX sshkeyname" 
}

