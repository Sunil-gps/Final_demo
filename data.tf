data "oci_identity_availability_domains" "ads" {
    #Required
    compartment_id = var.k8s_compartment
}

