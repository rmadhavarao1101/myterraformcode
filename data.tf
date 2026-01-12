##output "private-security-list-name" {
##  value = oci_core_security_list.private-security-list.display_name
##}
##output "private-security-list-OCID" {
##  value = oci_core_security_list.private-security-list.id
##}


data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_images" "all_windows_images" {
  compartment_id = var.compartment_ocid
  operating_system = "Windows"
  sort_by = "TIMECREATED"
}


