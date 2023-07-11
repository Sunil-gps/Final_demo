resource "oci_core_subnet" "assign_subnet_lb" {
    #Required
    vcn_id                      = oci_core_vcn.k8s_assign_vcn.id
    cidr_block                  = var.subnet_lb_info.CIDR     #"10.0.2.0/24"
    compartment_id = var.k8s_compartment

    #Optional
    #availability_domain = var.availability_domain   ...omitted becz we want regional subnet
    display_name                 = var.subnet_lb_info.name  #"subnet_lb"
    prohibit_public_ip_on_vnic  = false   #public subnet
    dns_label                   = var.subnet_lb_info.dns_label  #"subnetlb"
    route_table_id              = oci_core_route_table.route_table_lb.id
    security_list_ids           = [oci_core_security_list.security_list_lb.id]
}


resource "oci_core_subnet" "assign_subnet_worker" {
    #Required
    vcn_id                      = oci_core_vcn.k8s_assign_vcn.id
    cidr_block                  = var.subnet_worker_info.CIDR     #"10.0.1.0/24"
    compartment_id = var.k8s_compartment

    #Optional
    #availability_domain = var.availability_domain   ...omitted becz we want regional subnet
    display_name                 = var.subnet_worker_info.name  #"subnet_worker"
    prohibit_public_ip_on_vnic  = true   #private subnet
    dns_label                   = var.subnet_worker_info.dns_label  #"subnetworker"
    route_table_id              = oci_core_route_table.route_table_worker.id
    security_list_ids           = [oci_core_security_list.security_list_worker.id]
}


resource "oci_core_subnet" "assign_subnet_api" {
    #Required
    vcn_id                      = oci_core_vcn.k8s_assign_vcn.id
    cidr_block                  = var.subnet_api_info.CIDR     #"10.0.0.0/30"
    compartment_id = var.k8s_compartment

    #Optional
    #availability_domain = var.availability_domain   ...omitted becz we want regional subnet
    display_name                 = var.subnet_api_info.name  #"assign_subnet_api"
    prohibit_public_ip_on_vnic  = false   #public subnet
    dns_label                   = var.subnet_api_info.dns_label  #"assignsubnetapi"
    route_table_id              = oci_core_route_table.route_table_api.id
    security_list_ids           = [oci_core_security_list.security_list_api.id]
}
