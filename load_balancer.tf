# #Creates a new load balancer in the specified compartment
# resource "oci_load_balancer_load_balancer" "lb" {
#     #Required
#     compartment_id = var.k8s_compartment
#     display_name = var.lb_name  #"LB"
#     shape = "flexible"  #"Flexible"  ##A template that determines the total pre-provisioned bandwidth (ingress plus egress).
#     subnet_ids = [oci_core_subnet.assign_subnet_lb.id]

#     #Optional
#     ip_mode = "IPV4"  ##the service assigns an IPv4 address and the load balancer supports IPv4 traffic.
#     is_private = false
    
#     shape_details {
#         #Required
#         maximum_bandwidth_in_mbps = "50"
#         minimum_bandwidth_in_mbps = "10"
#     }
# }

# #Adds a backend set to a load balancer.
# resource "oci_load_balancer_backend_set" "lb_backend_set" {
#     #Required
#     load_balancer_id = oci_load_balancer_load_balancer.lb.id
#     name = var.backend_set_name 
#     policy = var.backend_set_policy   #"ROUND_ROBIN"

#     health_checker {
#         #Required
#         protocol = "TCP"  #The protocol the health check must use; either HTTP or TCP

#         #Optional
#         interval_ms = var.lb_health_check   #The interval between health checks, in milliseconds
#         port = "5000"  #he backend server port against which to run the health check
#         response_body_regex = ".*"
#         retries = "5"
#         return_code = "200"  #The status code a healthy backend server should return
#         url_path = "/"  #The path against which to run the health check
#     }
# }

# resource "oci_load_balancer_listener" "listener_tcp" {
#     #Required
#     default_backend_set_name = oci_load_balancer_backend_set.lb_backend_set.name
#     load_balancer_id = oci_load_balancer_load_balancer.lb.id
#     name = "listener_tcp"
#     port = "5000"   #The communication port for the listener
#     protocol = "TCP" 
# }

# data "oci_containerengine_node_pool" "k8s_node_pool" {
#     #Required
#     node_pool_id = oci_containerengine_node_pool.k8s_node_pool.id
# }

# resource "oci_load_balancer_backend" "lb_backend1" {
#     #Required
#     backendset_name = oci_load_balancer_backend_set.lb_backend_set.name
#     ip_address = data.oci_containerengine_node_pool.k8s_node_pool.nodes[0].private_ip
#     load_balancer_id = oci_load_balancer_load_balancer.lb.id
#     port =  "5000" #The communication port for the backend server

#     #Optional
#     backup = false
#     drain = false
#     offline = false
# }

# resource "oci_load_balancer_backend" "lb_backend2" {
#     #Required
#     backendset_name = oci_load_balancer_backend_set.lb_backend_set.name
#     ip_address = data.oci_containerengine_node_pool.k8s_node_pool.nodes[1].private_ip
#     load_balancer_id = oci_load_balancer_load_balancer.lb.id
#     port =  "5000" #The communication port for the backend server

#     #Optional
#     backup = false
#     drain = false
#     offline = false
# }

# resource "oci_load_balancer_backend" "lb_backend3" {
#     #Required
#     backendset_name = oci_load_balancer_backend_set.lb_backend_set.name
#     ip_address = data.oci_containerengine_node_pool.k8s_node_pool.nodes[2].private_ip
#     load_balancer_id = oci_load_balancer_load_balancer.lb.id
#     port =  "5000" #The communication port for the backend server

#     #Optional
#     backup = false
#     drain = false
#     offline = false
# }