resource "oci_containerengine_cluster" "k8s_cluster" {
  #Required
  compartment_id     = var.k8s_compartment
  kubernetes_version = "v1.26.2"
  name               = var.cluster_name
  vcn_id             = oci_core_vcn.k8s_assign_vcn.id

  #Optional
  cluster_pod_network_options {
        #Required
        cni_type = "Flannel_Overlay"
    }

  endpoint_config {
    #about CLuster API endpoint
    subnet_id             = oci_core_subnet.assign_subnet_api.id
    is_public_ip_enabled  = true #end point is public in a public subnet
  }

  options {
    service_lb_subnet_ids = [oci_core_subnet.assign_subnet_lb.id] # The OCIDs of the subnets used for Kubernetes services load balancers.

    #Optional
    add_ons {
      #flase becz our cluster is basic not enhanced
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }

    kubernetes_network_config {
      #Network configuration for K8s
      pods_cidr     = "10.244.0.0/16"  #default value="10.244.0.0/16"
      services_cidr = "10.96.0.0/16"   #default value="10.96.0.0/16"
    }
  }
}