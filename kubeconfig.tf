#this data source Create the Kubeconfig YAML for a cluster.

data "oci_containerengine_cluster_kube_config" "configurationfile" {
    #Required
    cluster_id = oci_containerengine_cluster.k8s_cluster.id
}


#outputing the generated kube config yaml file
output "config_of_cluster" {
    value = data.oci_containerengine_cluster_kube_config.configurationfile.content
}