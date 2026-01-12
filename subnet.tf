







data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}


resource "oci_core_subnet" "regional_subnet" {
  cidr_block        = var.web_subnet_cidr
  display_name      = "web-subnet-${var.client_name}-${local.region_key}-01"
  dns_label         = "regionalsubnet"
  #compartment_id    = var.compartment_ocid
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  vcn_id            = oci_core_vcn.vcn1.id
  security_list_ids = [oci_core_vcn.vcn1.default_security_list_id]
  route_table_id    = oci_core_vcn.vcn1.default_route_table_id
  dhcp_options_id   = oci_core_vcn.vcn1.default_dhcp_options_id
}


resource "oci_core_subnet" "regional_subnet22" {
  cidr_block        = var.app_subnet_cidr
  display_name      = "app-subnet-${var.client_name}-${local.region_key}-01"
  dns_label         = "regionalsubnet2"
  #compartment_id    = var.compartment_ocid
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  vcn_id            = oci_core_vcn.vcn1.id
  security_list_ids = [oci_core_security_list.my_security_list.id]
  route_table_id    = oci_core_route_table.my_route_table.id
  dhcp_options_id   = oci_core_vcn.vcn1.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true  # Ensures the subnet is private
}

resource "oci_core_subnet" "regional_subnet23" {
  cidr_block        = var.db_subnet_cidr
  display_name      = "db-subnet-${var.client_name}-${local.region_key}-01"
  dns_label         = "regionalsubnet3"
  #compartment_id    = var.compartment_ocid
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  vcn_id            = oci_core_vcn.vcn1.id
  security_list_ids = [oci_core_security_list.my_security_list.id]
  route_table_id    = oci_core_route_table.my_route_table.id
  dhcp_options_id   = oci_core_vcn.vcn1.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true  # Ensures the subnet is private
}
