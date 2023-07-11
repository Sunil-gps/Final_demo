#This is managed node pool 

resource "oci_containerengine_node_pool" "k8s_node_pool" {
    # Required
    cluster_id = oci_containerengine_cluster.k8s_cluster.id
    compartment_id = var.k8s_compartment
    node_shape = var.node_pool_node_shape
    name = var.node_pool_name
    
    # Optional
    kubernetes_version = "v1.26.2"

    # initial_node_labels {
    #     #A list of key/value pairs to add to nodes after they join the Kubernetes cluster.
    #     key = "name"
    #     value = var.cluster_name
    # }  

    node_config_details{
        placement_configs{
            availability_domain = "StBR:PHX-AD-1" #data.oci_identity_availability_domains.ads.availability_domains[0].name
            subnet_id = oci_core_subnet.assign_subnet_worker.id
        } 
        placement_configs{
            availability_domain =  "StBR:PHX-AD-2" #data.oci_identity_availability_domains.ads.availability_domains[1].name
            subnet_id = oci_core_subnet.assign_subnet_worker.id
        }
         placement_configs{
            availability_domain =  "StBR:PHX-AD-3" #data.oci_identity_availability_domains.ads.availability_domains[2].name
            subnet_id = oci_core_subnet.assign_subnet_worker.id
        }

        size = 3   #The number of nodes that should be in the node pool. 
        
    }

    node_shape_config {
        #Optional
        memory_in_gbs = "64"
        ocpus = "4"
    }
    
    node_source_details {
         image_id = var.node_pool_image_id
         source_type = "IMAGE"
    }

    ssh_public_key = var.ssh_key  
}