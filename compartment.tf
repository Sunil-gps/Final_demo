# data "oci_identity_availability_domains" "ads" {
#   compartment_id = var.tenacy_ocid
# }

# resource "oci_identity_compartment" "k8s_compartment" {
#     # Required
#     compartment_id = var.tenacy_ocid
#     description = "Compartment for Terraform resources for K8s cluster"
#     name = var.compartment_name
#     #enable_delete = truec
# }