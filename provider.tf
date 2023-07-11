# terraform {
#   required_providers {
#     oci = {
#       source = "oracle/oci"
#       version = "5.0.0"
#     }
#   }
# }

provider "oci" {
  tenancy_ocid = var.tenacy_ocid
  user_ocid = var.user_ocid
  #private_key_path = "/users/sunilcho/.oci/key_name.pem"
  fingerprint = var.fingerprint
  region = var.region
}
