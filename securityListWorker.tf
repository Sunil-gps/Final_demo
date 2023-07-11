resource "oci_core_security_list" "security_list_worker" {
    #Required
    compartment_id = var.k8s_compartment
    vcn_id = oci_core_vcn.k8s_assign_vcn.id

    #Optional
    display_name = var.security_list_worker_info.name
    
    ingress_security_rules {
        #Required
        protocol = "all"
        source = var.subnet_worker_info.CIDR    #10.0.1.0/24 worker nodes cidr

        #Optional
        description = "Ingress rule for worker subnet: Allow pods on one worker node to communicate with pods on other worker nodes"
        
        source_type = "CIDR_BLOCK"
        stateless = false
    }
    
    ingress_security_rules {
        #Required
        protocol = "6"
        source = var.subnet_api_info.CIDR    #10.0.1.0/30 control plane cidr

        #Optional
        description = "Ingress rule for worker subnet: Allow Kubernetes control plane to communicate with worker nodes."
        
        source_type = "CIDR_BLOCK"
        stateless = false
    }

    ingress_security_rules {
        #Required
        protocol = "6"
        source = "0.0.0.0/0"    

        #Optional
        description = "Ingress rule for worker subnet: Inbound SSH traffic to worker node"
        
        source_type = "CIDR_BLOCK"
        stateless = false
    }

    ingress_security_rules {
        #Required
        protocol = "6"  
        source =   var.subnet_lb_info.CIDR #Load balancer subnet CIDR

        #Optional
        description = "Ingress rule for worker subnet: Load balancer to worker nodes node ports"
        
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {
            #Optional
            max = "32767"
            min = "30000"
        }
    }


    ingress_security_rules {
        #Required
        protocol = "6"  
        source =   var.subnet_lb_info.CIDR #Load balancer subnet CIDR

        #Optional
        description = "Ingress rule for worker subnet: Allow load balancer to communicate with kube-proxy on worker nodes"
        
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {
            #Optional
            max = "10256"
            min = "10256"
        }
    }

    ingress_security_rules {
        #Required
        protocol = "1"  
        source =   var.subnet_api_info.CIDR #Load balancer subnet CIDR

        #Optional
        description = "Ingress rule for worker subnet: Path discovery"
        
        source_type = "CIDR_BLOCK"
        stateless = false

        icmp_options {
            #Required
            type = "3"  #destination unreachable

            #Optional
            code = "4"   #fragmentation needed
        }
    }

    ingress_security_rules {
        #Required
        protocol = "all"
        source = "0.0.0.0/0"   

        #Optional
        description = "Ingress rule for worker subnet"
        
        source_type = "CIDR_BLOCK"
        stateless = false
    }

    egress_security_rules {
        #Required
        destination =  "0.0.0.0/0" #external 
        protocol = "all"  

        #Optional
        description = "Egress rule for worker subnet: Internet access to worker nodes"
        destination_type = "CIDR_BLOCK"
        stateless = false
    }



    egress_security_rules {
        #Required
        destination =var.subnet_worker_info.CIDR #worker nodes cidr
        protocol = "all"  

        #Optional
        description = "Egress rule for worker subnet: Allow pods on one worker node to communicate with pods on other worker nodes"
        destination_type = "CIDR_BLOCK"
        stateless = false
    }

    egress_security_rules {
        #Required
        destination = var.subnet_api_info.CIDR    #Kubernetes API Endpoint CIDR
        protocol = "6"  #TCP

        #Optional
        description = "Egress rule for worker subnet: Kubernetes worker to Kubernetes API endpoint communication"
        destination_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {
            #Optional
            max = "6443"
            min = "6443"
        }
    } 

    egress_security_rules {
        #Required
        destination = var.subnet_api_info.CIDR    #Kubernetes API Endpoint CIDR
        protocol = "6"  #TCP

        #Optional
        description = "Egress rule for worker subnet: Kubernetes worker to control plane communication"
        destination_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {
            #Optional
            max = "12250"
            min = "12250"
        }
    } 

    egress_security_rules {
        #Required
        destination = var.subnet_api_info.CIDR    
        protocol = "1"  #ICMP

        #Optional
        description = "Egress rule for worker subnet: path discovery"
        destination_type = "CIDR_BLOCK"
        stateless = false

        icmp_options {
            #Required
            type = "3"  #destination unreachable

            #Optional
            code = "4"   #fragmentation needed
        }
    }

    egress_security_rules {
        #Required
        destination =  "all-phx-services-in-oracle-services-network" #"All <region> Services in Oracle Services Network"  #all regional services in oracle service network
        protocol = "6"  #TCP

        #Optional
        description = "Egress rule for worker subnet: Allow worker nodes to communicate with OKE"
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
        destination = "0.0.0.0/0"    
        protocol = "1"  #ICMP

        #Optional
        description = "Egress rule for worker subnet: path discovery"
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
