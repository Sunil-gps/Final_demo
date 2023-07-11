resource "oci_core_route_table" "route_table_api" {
    #Required
    compartment_id = var.k8s_compartment
    vcn_id           = oci_core_vcn.k8s_assign_vcn.id

    #Optional
    display_name = var.route_table_api_info.name
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.internet_gateway.id   #ocid of route rule's target

        #Optional
        description       = "Route rule for API Endpoint subnet"
        destination       = var.route_table_api_info.route_rule.destination   #0.0.0.0/0
        destination_type  = var.route_table_api_info.route_rule.destination_type    #"CIDR_BLOCK"
    }
}

resource "oci_core_route_table" "route_table_worker" {
    #Required
    compartment_id = var.k8s_compartment
    vcn_id           = oci_core_vcn.k8s_assign_vcn.id

    #Optional
    display_name = var.route_table_worker_info.name
    route_rules {
        #Required
        network_entity_id = oci_core_nat_gateway.nat_gateway.id

        #Optional
        description       = "Route rule for traffic to internet in worker subnet"
        destination       = var.route_table_worker_info.route_rule.destination   #0.0.0.0/0
        destination_type  = var.route_table_worker_info.route_rule.destination_type    #"CIDR_BLOCK"
    }
    route_rules {
        #Required
        network_entity_id = oci_core_service_gateway.service_gateway.id

        #Optional
        description       = "Route rule for traffic to services in worker subnet"
        destination       = "all-phx-services-in-oracle-services-network"   #cidr block value for all services
        destination_type  = var.route_table_worker_info.route_rule2.destination_type    #"SERVICE_CIDR_BLOCK"
    }
}

resource "oci_core_route_table" "route_table_lb" {
    #Required
    compartment_id = var.k8s_compartment
    vcn_id           = oci_core_vcn.k8s_assign_vcn.id

    #Optional
    display_name = var.route_table_lb_info.name
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.internet_gateway.id

        #Optional
        description       = "Route rule for lb subnet"
        destination       = var.route_table_lb_info.route_rule.destination   #0.0.0.0/0
        destination_type  = var.route_table_lb_info.route_rule.destination_type    #"CIDR_BLOCK"
    }
}