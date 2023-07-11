resource "oci_core_security_list" "security_list_lb" {
    #Required
    compartment_id = var.k8s_compartment
    vcn_id = oci_core_vcn.k8s_assign_vcn.id

    #Optional
    display_name = var.security_list_lb_info.name
    
    ingress_security_rules {
        #Required
        protocol = "6"
        source = "0.0.0.0/0"    #any

        #Optional
        description = "Ingress rule for lb subnet: Load balancer listener protocol and port"
        
        source_type = "CIDR_BLOCK"
        stateless = false
    }

    egress_security_rules {
        #Required
        destination =  var.subnet_worker_info.CIDR #worker nodes cidr
        protocol = "6"  

        #Optional
        description = "Egress rule for lb subnet: Load balancer to worker nodes node ports"
        destination_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {
            #Optional
            max = "32767"
            min = "30000"
        }
    }

    egress_security_rules {
        #Required
        destination =  var.subnet_worker_info.CIDR #worker nodes cidr
        protocol = "6"  

        #Optional
        description = "Egress rule for lb subnet: Allow load balancer to communicate with kube-proxy health port on worker nodes"
        destination_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {
            #Optional
            max = "10256"
            min = "10256"
        }
    }
}
