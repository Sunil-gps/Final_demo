# #This resource provides the Addon resource in Oracle Cloud Infrastructure Container Engine service.
# #Install the specified addon for a cluster.

# resource "oci_containerengine_addon" "dashboard" {
#     #Required
#     addon_name = "KubernetesDashboard"
#     cluster_id = oci_containerengine_cluster.k8s_cluster.id
#     remove_addon_resources_on_delete = true
#     # configurations {
#     #     key = ""
#     #     value = ""
#     # }


#     #version = ....## version of the addon to be installed
# }