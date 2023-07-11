resource "oci_core_security_list" "security_list_api" {
    #Required
    compartment_id = var.k8s_compartment
    vcn_id = oci_core_vcn.k8s_assign_vcn.id

    #Optional
    display_name = var.security_list_api_info.name
    
    ingress_security_rules {
        #Required
        protocol = "all" 
        source = "0.0.0.0/0"    #external access

        #Optional
        description = "Ingress rule for API subnet: Internet to API endpoint"
        
        source_type = "CIDR_BLOCK"
        stateless = false
    }

    ingress_security_rules {
        #Required
        protocol = "6"  #TCP==="6"
        source = "0.0.0.0/0"    #external access

        #Optional
        description = "Ingress rule for API subnet: Internet to API endpoint"
        
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {
            min= "6443"
            max = "6443"
        }
    }



    ingress_security_rules {
        #Required
        protocol = "6"  #TCP==="6"
        source = var.subnet_worker_info.CIDR    #10.0.1.0/24 worker nodes cidr

        #Optional
        description = "Ingress rule for API subnet: worker node to API endpoint communication"
        
        source_type = "CIDR_BLOCK"
        stateless = false
        tcp_options {
            #Optional
            max = "6443"
            min = "6443"
        }
    }
    
    ingress_security_rules {
        #Required
        protocol = "6"  #TCP==="6"
        source = var.subnet_worker_info.CIDR    #10.0.1.0/24 worker nodes cidr

        #Optional
        description = "Ingress rule for API subnet: worker node to control plane communication"
        
        source_type = "CIDR_BLOCK"
        stateless = false
        tcp_options {
            #Optional
            max = "12250"
            min = "12250"
        }
    }

    ingress_security_rules {
        #Required
        protocol = "1"  #ICMP==="1"
        source = "10.0.1.0/24"    #10.0.1.0/24 worker nodes cidr

        #Optional
        description = "Ingress rule for API subnet: Path discovery"
        
        source_type = "CIDR_BLOCK"
        stateless = false
        icmp_options {
            #Required
            type = "3" #destination unreachable
            #Optional
            code = "4" #fragmentationn needed
        }
    }


    egress_security_rules {
        #Required
        destination =  "all-phx-services-in-oracle-services-network" #"All <region> Services in Oracle Services Network" #all regional services in oracle service network
        protocol = "6"  #TCP

        #Optional
        description = "Egress rule for API subnet: control plane to OKE"
        destination_type = "SERVICE_CIDR_BLOCK"
        stateless = false
        
        tcp_options {
            #Optional
            max = "443"
            min = "443" 
        }
    }

    egress_security_rules {
        #Required
        destination = var.subnet_worker_info.CIDR    #worker nodes cidr
        protocol = "6"  #TCP

        #Optional
        description = "Egress rule for API subnet: control plane to worker nodes"
        destination_type = "CIDR_BLOCK"
        stateless = false

        #all destination ports are allowed
    }

    egress_security_rules {
        #Required
        destination = var.subnet_worker_info.CIDR    #worker nodes cidr
        protocol = "1"  #ICMP

        #Optional
        description = "Egress rule for API subnet: control plane to worker nodes: Path discovert"
        destination_type = "CIDR_BLOCK"
        stateless = false

        icmp_options {
            #Required
            type = "3"  #destination unreachable

            #Optional
            code = "4"   #fragmentation needed
        }
    } 
}