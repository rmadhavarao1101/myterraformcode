output "home_region_key" {
  value = data.oci_identity_region_subscriptions.this.region_subscriptions[0].region_key
}


output "service_gateway_id" {
  description = "id of service gateway if it is created"
  value       = join(",", oci_core_service_gateway.service_gateway[*].id)
}



output "service_gateway_all_attributes" {
  description = "all attributes of created service gateway"
  value       = { for k, v in oci_core_service_gateway.service_gateway : k => v }
}

output "security_list_id" {
  value = oci_core_security_list.my_security_list.id
}

##### DB server output #####

output "db_system_id" {
  value = oci_database_db_system.my_db_system.id
}

output "db_system_name" {
  value = oci_database_db_system.my_db_system.display_name
}


output "db_private_ip" {
  value = oci_database_db_system.my_db_system.private_ip
}


#### application server output ####


output "instance_id" {
  value = oci_core_instance.my_windows_instance.id
}

output "instance_public_ip" {
  value = oci_core_instance.my_windows_instance.public_ip
}

output "instance_private_ip" {
  value = oci_core_instance.my_windows_instance.private_ip
}

##### Bastion Server Output #####
#output "bastion_session_state" {
#           value = oci_bastion_session.my_bastion_session.state
#}
#output "bastion_session_target_resource_details" {
#           value = oci_bastion_session.my_bastion_session.target_resource_details
#}
#output "bastion_session_ssh_connection" {
#           value = oci_bastion_session.my_bastion_session.ssh_metadata.command
#}  
