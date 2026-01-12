

resource "oci_identity_compartment" "parent_compartment" {
    # Required
    compartment_id = var.compartment_ocid
    description = "Compartment for Terraform resources."
    name = "comp-${var.client_name}-${local.region_key}-01"
}
resource "oci_identity_compartment" "sub_compartment_app" {
    # Required
    compartment_id = oci_identity_compartment.parent_compartment.id
    description = "Compartment for Terraform resources."
    name = "comp-application-${var.client_name}-${local.region_key}-01"
}
resource "oci_identity_compartment" "sub_compartment_net" {
    # Required
    compartment_id = oci_identity_compartment.parent_compartment.id
    description = "Compartment for Terraform resources."
    name = "comp-network-${var.client_name}-${local.region_key}-01"
}

resource "oci_identity_compartment" "sub_compartment_sec" {
    # Required
    compartment_id = oci_identity_compartment.parent_compartment.id
    description = "Compartment for Terraform resources."
    name = "comp-security-${var.client_name}-${local.region_key}-01"
}
resource "oci_identity_compartment" "sub_compartments_db" {
    # Required
    compartment_id = oci_identity_compartment.parent_compartment.id
    description = "Compartment for Terraform resources."
    name = "comp-database-${var.client_name}-${local.region_key}-01"
}


locals {
  region_key = lower(data.oci_identity_region_subscriptions.this.region_subscriptions[0].region_key)
}

