# #Cluster with Flannel CNI plugin,
# #with Public K8s API endpoint,
# #with Private Worker Nodes, 
# #with Public Load Balancers

# resource "oci_core_vcn" "k8s_assign_vcn" {
#   dns_label      = var.vcn_info.dns_label
#   cidr_blocks    = var.vcn_info.cidr_blocks
#   compartment_id = var.k8s_compartment
#   display_name   = var.vcn_info.name
# }

# resource "oci_core_internet_gateway" "internet_gateway" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.igw_info.name #k8s_igw
#     enabled = var.igw_info.enabled #true
#     #route_table_id = oci_core_route_table.assign_route_table.id
# }

# resource "oci_core_nat_gateway" "nat_gateway" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     block_traffic = var.ngw_info.block_traffic   # "false"
#     display_name = var.ngw_info.name
#     #public_ip_id = oci_core_public_ip.test_public_ip.id
#     #route_table_id = oci_core_route_table.test_route_table.id
# }

# data "oci_core_services" "k8s_services" {
# }

# resource "oci_core_service_gateway" "service_gateway" {
#     #Required
#     compartment_id = var.k8s_compartment
#     services {
#         #Required
#         service_id = data.oci_core_services.k8s_services.services.0.id
#     }
#     vcn_id = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.sgw_info.name
#     #route_table_id = oci_core_route_table.test_route_table.id
# }

# resource "oci_core_route_table" "route_table_api" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id           = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.route_table_api_info.name
#     route_rules {
#         #Required
#         network_entity_id = oci_core_internet_gateway.internet_gateway.id   #ocid of route rule's target

#         #Optional
#         description       = "Route rule for API Endpoint subnet"
#         destination       = var.route_table_api_info.route_rule.destination   #0.0.0.0/0
#         destination_type  = var.route_table_api_info.route_rule.destination_type    #"CIDR_BLOCK"
#     }
# }

# resource "oci_core_route_table" "route_table_worker" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id           = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.route_table_worker_info.name
#     route_rules {
#         #Required
#         network_entity_id = oci_core_nat_gateway.nat_gateway.id

#         #Optional
#         description       = "Route rule for traffic to internet in worker subnet"
#         destination       = var.route_table_worker_info.route_rule.destination   #0.0.0.0/0
#         destination_type  = var.route_table_worker_info.route_rule.destination_type    #"CIDR_BLOCK"
#     }
#     route_rules {
#         #Required
#         network_entity_id = oci_core_service_gateway.service_gateway.id

#         #Optional
#         description       = "Route rule for traffic to services in worker subnet"
#         destination       = "all-phx-services-in-oracle-services-network"   #cidr block value for all services
#         destination_type  = var.route_table_worker_info.route_rule2.destination_type    #"SERVICE_CIDR_BLOCK"
#     }
# }

# resource "oci_core_route_table" "route_table_lb" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id           = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.route_table_lb_info.name
#     route_rules {
#         #Required
#         network_entity_id = oci_core_internet_gateway.internet_gateway.id

#         #Optional
#         description       = "Route rule for lb subnet"
#         destination       = var.route_table_lb_info.route_rule.destination   #0.0.0.0/0
#         destination_type  = var.route_table_lb_info.route_rule.destination_type    #"CIDR_BLOCK"
#     }
# }

# resource "oci_core_security_list" "security_list_api" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.security_list_api_info.name
    
#     ingress_security_rules {
#         #Required
#         protocol = "6"  #TCP==="6"
#         source = "10.0.1.0/24"    #10.0.1.0/24 worker nodes cidr

#         #Optional
#         description = "Ingress rule for API subnet: worker node to API endpoint"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false
#         tcp_options {
#             #Optional
#             max = "6443"
#             min = "6443"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }
    
#     ingress_security_rules {
#         #Required
#         protocol = "6"  #TCP==="6"
#         source = "10.0.1.0/24"    #10.0.1.0/24 worker nodes cidr

#         #Optional
#         description = "Ingress rule for API subnet: worker node to control plane"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false
#         tcp_options {
#             #Optional
#             max = "12250"
#             min = "12250"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }

#     ingress_security_rules {
#         #Required
#         protocol = "1"  #ICMP==="1"
#         source = "10.0.1.0/24"    #10.0.1.0/24 worker nodes cidr

#         #Optional
#         description = "Ingress rule for API subnet: Path discovery"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false
#         icmp_options {
#             #Required
#             type = "3" #destination unreachable

#             #Optional
#             code = "4" #fragmentationn needed
#         }
#     }


#     egress_security_rules {
#         #Required
#         destination =  "all-phx-services-in-oracle-services-network" #"All <region> Services in Oracle Services Network" #all regional services in oracle service network
#         protocol = "6"  #TCP

#         #Optional
#         description = "Egress rule for API subnet: control plane to OKE"
#         destination_type = "SERVICE_CIDR_BLOCK"
#         stateless = false


#         #all destination ports are allowed
#         # tcp_options {

#         #     #Optional
#         #     max = var.security_list_egress_security_rules_tcp_options_destination_port_range_max
#         #     min = var.security_list_egress_security_rules_tcp_options_destination_port_range_min
#         #     source_port_range {
#         #         #Required
#         #         max = var.security_list_egress_security_rules_tcp_options_source_port_range_max
#         #         min = var.security_list_egress_security_rules_tcp_options_source_port_range_min
#         #     }
#         # }
#     }

#     egress_security_rules {
#         #Required
#         destination = "10.0.1.0/24"    #worker nodes cidr
#         protocol = "6"  #TCP

#         #Optional
#         description = "Egress rule for API subnet: control plane to worker nodes"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         #all destination ports are allowed
#         # tcp_options {

#         #     #Optional
#         #     max = var.security_list_egress_security_rules_tcp_options_destination_port_range_max
#         #     min = var.security_list_egress_security_rules_tcp_options_destination_port_range_min
#         #     source_port_range {
#         #         #Required
#         #         max = var.security_list_egress_security_rules_tcp_options_source_port_range_max
#         #         min = var.security_list_egress_security_rules_tcp_options_source_port_range_min
#         #     }
#         # }
#     }

#     egress_security_rules {
#         #Required
#         destination =  "all-phx-services-in-oracle-services-network" #"All <region> Services in Oracle Services Network"  #all regional services in oracle service network
#         protocol = "6"  #TCP

#         #Optional
#         description = "Egress rule for API subnet: control plane to OKE : Path discovery"
#         destination_type = "SERVICE_CIDR_BLOCK"
#         stateless = false

#         icmp_options {
#             #Required
#             type = "3"  #destination unreachable

#             #Optional
#             code = "4"   #fragmentation needed
#         }
        
#     }

#     egress_security_rules {
#         #Required
#         destination = "10.0.1.0/24"    #worker nodes cidr
#         protocol = "6"  #TCP

#         #Optional
#         description = "Egress rule for API subnet: control plane to worker nodes: Path discovert"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         icmp_options {
#             #Required
#             type = "3"  #destination unreachable

#             #Optional
#             code = "4"   #fragmentation needed
#         }
#     } 
# }

# resource "oci_core_subnet" "assign_subnet_api" {
#     #Required
#     vcn_id                      = oci_core_vcn.k8s_assign_vcn.id
#     cidr_block                  = var.subnet_api_info.CIDR     #"10.0.0.0/30"
#     compartment_id = var.k8s_compartment

#     #Optional
#     #availability_domain = var.availability_domain   ...omitted becz we want regional subnet
#     display_name                 = var.subnet_api_info.name  #"assign_subnet_api"
#     prohibit_public_ip_on_vnic  = false   #public subnet
#     dns_label                   = var.subnet_api_info.dns_label  #"assignsubnetapi"
#     route_table_id              = oci_core_route_table.route_table_api.id
#     security_list_ids           = [oci_core_security_list.security_list_api.id]
# }




# resource "oci_core_security_list" "security_list_worker" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.security_list_worker_info.name
    
#     ingress_security_rules {
#         #Required
#         protocol = "all"
#         source = "10.0.1.0/24"    #10.0.1.0/24 worker nodes cidr

#         #Optional
#         description = "Ingress rule for worker subnet: Allow pods on one worker node to communicate with pods on other worker nodes"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false
        
#     }
    
#     ingress_security_rules {
#         #Required
#         protocol = "6"
#         source = "10.0.1.0/30"    #10.0.1.0/30 control plane cidr

#         #Optional
#         description = "Ingress rule for worker subnet: Allow Kubernetes control plane to communicate with worker nodes."
        
#         source_type = "CIDR_BLOCK"
#         stateless = false
        
#     }

#     ingress_security_rules {
#         #Required
#         protocol = "1"  #ICMP==="1"
#         source = "0.0.0.0/0"   

#         #Optional
#         description = "Ingress rule for worker subnet: Path discovery"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false
#         icmp_options {
#             #Required
#             type = "3" #destination unreachable

#             #Optional
#             code = "4" #fragmentationn needed
#         }
#     }

#     ingress_security_rules {
#         #Required
#         protocol = "6"  
#         source =   "10.0.2.0/24" #Load balancer subnet CIDR

#         #Optional
#         description = "Ingress rule for worker subnet: Load balancer to worker nodes node ports"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false

#         tcp_options {
#             #Optional
#             max = "32767"
#             min = "30000"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }
#     ingress_security_rules {
#         #Required
#         protocol = "17"  
#         source =   "10.0.2.0/24" #Load balancer subnet CIDR

#         #Optional
#         description = "Ingress rule for worker subnet: Load balancer to worker nodes node ports"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false

#         udp_options {
#             #Optional
#             max = "32767"
#             min = "30000"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }

#     ingress_security_rules {
#         #Required
#         protocol = "6"  
#         source =   "10.0.2.0/24" #Load balancer subnet CIDR

#         #Optional
#         description = "Ingress rule for worker subnet: Allow load balancer to communicate with kube-proxy on worker nodes"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false

#         tcp_options {
#             #Optional
#             max = "10256"
#             min = "10256"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }

#     ingress_security_rules {
#         #Required
#         protocol = "17"  
#         source =   "10.0.2.0/24" #Load balancer subnet CIDR

#         #Optional
#         description = "Ingress rule for worker subnet: Allow load balancer to communicate with kube-proxy on worker nodes"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false

#         udp_options {
#             #Optional
#             max = "10256"
#             min = "10256"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }


#     egress_security_rules {
#         #Required
#         destination =  "10.0.1.0/24" #worker nodes cidr
#         protocol = "all"  

#         #Optional
#         description = "Egress rule for worker subnet: Allow pods on one worker node to communicate with pods on other worker nodes"
#         destination_type = "CIDR_BLOCK"
#         stateless = false
#     }

#     egress_security_rules {
#         #Required
#         destination = "0.0.0.0/0"    
#         protocol = "1"  #ICMP

#         #Optional
#         description = "Egress rule for worker subnet: path discovery"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         icmp_options {
#             #Required
#             type = "3"  #destination unreachable

#             #Optional
#             code = "4"   #fragmentation needed
#         }
#     }

#     egress_security_rules {
#         #Required
#         destination =  "all-phx-services-in-oracle-services-network" #"All <region> Services in Oracle Services Network"  #all regional services in oracle service network
#         protocol = "6"  #TCP

#         #Optional
#         description = "Egress rule for worker subnet: Allow worker nodes to communicate with OKE"
#         destination_type = "SERVICE_CIDR_BLOCK"
#         stateless = false
#     }

#     egress_security_rules {
#         #Required
#         destination = "10.0.0.0/30"    #Kubernetes API Endpoint CIDR
#         protocol = "6"  #TCP

#         #Optional
#         description = "Egress rule for worker subnet: Kubernetes worker to Kubernetes API endpoint communication"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         tcp_options {
#             #Optional
#             max = "6443"
#             min = "6443"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
        
#     } 

#     egress_security_rules {
#         #Required
#         destination = "10.0.0.0/30"    #Kubernetes API Endpoint CIDR
#         protocol = "6"  #TCP

#         #Optional
#         description = "Egress rule for worker subnet: Kubernetes worker to control plane communication"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         tcp_options {
#             #Optional
#             max = "12250"
#             min = "12250"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     } 
# }

# resource "oci_core_subnet" "assign_subnet_worker" {
#     #Required
#     vcn_id                      = oci_core_vcn.k8s_assign_vcn.id
#     cidr_block                  = var.subnet_worker_info.CIDR     #"10.0.1.0/24"
#     compartment_id = var.k8s_compartment

#     #Optional
#     #availability_domain = var.availability_domain   ...omitted becz we want regional subnet
#     display_name                 = var.subnet_worker_info.name  #"subnet_worker"
#     prohibit_public_ip_on_vnic  = true   #private subnet
#     dns_label                   = var.subnet_worker_info.dns_label  #"subnetworker"
#     route_table_id              = oci_core_route_table.route_table_worker.id
#     security_list_ids           = [oci_core_security_list.security_list_worker.id]
# }

# resource "oci_core_security_list" "security_list_lb" {
#     #Required
#     compartment_id = var.k8s_compartment
#     vcn_id = oci_core_vcn.k8s_assign_vcn.id

#     #Optional
#     display_name = var.security_list_lb_info.name
    
#     ingress_security_rules {
#         #Required
#         protocol = "6"
#         source = "0.0.0.0/0"    #internet

#         #Optional
#         description = "Ingress rule for lb subnet: Load balancer listener protocol and port. Customize as required"
        
#         source_type = "CIDR_BLOCK"
#         stateless = false
        
#     }

#     egress_security_rules {
#         #Required
#         destination =  "10.0.1.0/24" #worker nodes cidr
#         protocol = "6"  

#         #Optional
#         description = "Egress rule for lb subnet: Load balancer to worker nodes node ports"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         tcp_options {
#             #Optional
#             max = "32767"
#             min = "30000"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }

#     egress_security_rules {
#         #Required
#         destination =  "10.0.1.0/24" #worker nodes cidr
#         protocol = "17"  

#         #Optional
#         description = "Egress rule for lb subnet: Load balancer to worker nodes node ports"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         udp_options {
#             #Optional
#             max = "32767"
#             min = "30000"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }

#     egress_security_rules {
#         #Required
#         destination =  "10.0.1.0/24" #worker nodes cidr
#         protocol = "6"  

#         #Optional
#         description = "Egress rule for lb subnet: Allow load balancer to communicate with kube-proxy on worker nodes"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         tcp_options {
#             #Optional
#             max = "10256"
#             min = "10256"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
#     }

#     egress_security_rules {
#         #Required
#         destination =  "10.0.1.0/24" #worker nodes cidr
#         protocol = "17"  

#         #Optional
#         description = "Egress rule for lb subnet: Allow load balancer to communicate with kube-proxy on worker nodes"
#         destination_type = "CIDR_BLOCK"
#         stateless = false

#         udp_options {
#             #Optional
#             max = "10256"
#             min = "10256"
#             # source_port_range {
#             #     #Required
#             #     max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
#             #     min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
#             # }
#         }
        
#     }
# }


# resource "oci_core_subnet" "assign_subnet_lb" {
#     #Required
#     vcn_id                      = oci_core_vcn.k8s_assign_vcn.id
#     cidr_block                  = var.subnet_lb_info.CIDR     #"10.0.2.0/24"
#     compartment_id = var.k8s_compartment

#     #Optional
#     #availability_domain = var.availability_domain   ...omitted becz we want regional subnet
#     display_name                 = var.subnet_lb_info.name  #"subnet_lb"
#     prohibit_public_ip_on_vnic  = false   #public subnet
#     dns_label                   = var.subnet_lb_info.dns_label  #"subnetlb"
#     route_table_id              = oci_core_route_table.route_table_lb.id
#     security_list_ids           = [oci_core_security_list.security_list_lb.id]
# }

# resource "oci_core_instance" "api_instance" {
#     # Required
#     availability_domain = "StBR:PHX-AD-1"
#     compartment_id = var.k8s_compartment
#     shape = var.apicompute_info.shape


#     #Optional
#     source_details {
#         source_id = var.apicompute_info.source_id
#         source_type =   var.apicompute_info.source_type
#         #"image"
#     }

#     shape_config {
#         #Optional
#         memory_in_gbs = "64"
#         ocpus = "4"
#     }

#     display_name = var.apicompute_info.name
#     #"assign_instance"
#     create_vnic_details {
#         #assign_public_ip = true  ..defaults to subnet type
#         subnet_id = oci_core_subnet.assign_subnet_api.id
#     }
#     preserve_boot_volume = false
#     metadata = {
#         ssh_authorized_keys = var.ssh_key
#     }
# }

# # resource "oci_core_instance" "worker_instance1" {
# #     # Required
# #     availability_domain = "StBR:PHX-AD-1"
# #     compartment_id = var.k8s_compartment
# #     #shape = "VM.Standard.E2.1.Micro"
# #     shape = var.workercompute_info1.shape


# #     #Optional
# #     source_details {
# #         #source_id = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa6kso2osabotubs6qvm3atjhbhrrc5yyg7fv2sh2rj3semz3ncrua"
# #         source_id = var.workercompute_info1.source_id
# #         source_type =   var.workercompute_info1.source_type
# #         #"image"
# #     }

# #     shape_config {
# #         #Optional
# #         memory_in_gbs = "64"
# #         ocpus = "4"
# #     }

# #     display_name = var.workercompute_info1.name
# #     #"assign_instance"
# #     create_vnic_details {
# #         assign_public_ip = false
# #         subnet_id = oci_core_subnet.assign_subnet_worker.id
# #     }
# #     metadata = {
# #         ssh_authorized_keys = var.ssh_key
# #     }
# #     preserve_boot_volume = false
# # }

# # resource "oci_core_instance" "worker_instance2" {
# #     # Required
# #     availability_domain = "StBR:PHX-AD-1"
# #     compartment_id = var.k8s_compartment
# #     shape = var.workercompute_info2.shape


# #     #Optional
# #     source_details {
# #         source_id = var.workercompute_info2.source_id
# #         source_type =   var.workercompute_info2.source_type
# #         #"image"
# #     }

# #     shape_config {
# #         #Optional
# #         memory_in_gbs = "64"
# #         ocpus = "4"
# #     }


# #     display_name = var.workercompute_info2.name
# #     #"assign_instance"
# #     create_vnic_details {
# #         assign_public_ip = false
# #         subnet_id = oci_core_subnet.assign_subnet_worker.id
# #     }
# #     metadata = {
# #         ssh_authorized_keys = var.ssh_key
# #     }
# #     preserve_boot_volume = false
# # }

