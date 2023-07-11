resource "oci_core_vcn" "k8s_assign_vcn" {
  dns_label      = var.vcn_info.dns_label
  cidr_blocks    = var.vcn_info.cidr_blocks
  compartment_id = var.k8s_compartment
  display_name   = var.vcn_info.name
}