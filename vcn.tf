resource "oci_core_vcn" "vcn1" {
  cidr_block     = var.vcn_cidr
  dns_label      = "vcn1"
  ##compartment_id = var.compartment_ocid
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  display_name   = "vcn-${var.client_name}-${local.region_key}-01"
}


resource "oci_core_nat_gateway" "my_nat_gateway" {
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "ng-${var.client_name}-${local.region_key}-01"
}




#######################
# Service Gateway (SGW)
#######################


data "oci_core_services" "all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
  count = var.create_service_gateway == true ? 1 : 0
}

resource "oci_core_service_gateway" "service_gateway" {
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  display_name   = var.label_prefix == "none" ? var.service_gateway_display_name : "${var.label_prefix}-${var.service_gateway_display_name}"

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
  services {
    service_id = lookup(data.oci_core_services.all_oci_services[0].services[0], "id")
  }

  vcn_id = oci_core_vcn.vcn1.id

  lifecycle {
    ignore_changes = [defined_tags, freeform_tags]
  }

  count = var.create_service_gateway == true ? 1 : 0
}





resource "oci_core_route_table" "my_route_table" {
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "rt-priv-subnet-${oci_core_vcn.vcn1.display_name}"
  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.my_nat_gateway.id
  }


  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags

  dynamic "route_rules" {
    # * If Service Gateway is created with the module, automatically creates a rule to handle traffic for "all services" through Service Gateway
    for_each = var.create_service_gateway == true ? [1] : []

    content {
      destination       = lookup(data.oci_core_services.all_oci_services[0].services[0], "cidr_block")
      destination_type  = "SERVICE_CIDR_BLOCK"
      network_entity_id = oci_core_service_gateway.service_gateway[0].id
      description       = "Terraformed - Auto-generated at Service Gateway creation: All Services in region to Service Gateway"
    }
  }



}


########################
## Internet Gateway (IG)
########################

resource "oci_core_internet_gateway" "my_internet_gateway" {
  #compartment_id = var.compartment_ocid
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  display_name   = "ig-${var.client_name}-${local.region_key}-01"
  vcn_id         = oci_core_vcn.vcn1.id
}


resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.vcn1.default_route_table_id
  display_name               = "defaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.my_internet_gateway.id
  }
}


resource "oci_core_default_dhcp_options" "default_dhcp_options" {
  manage_default_resource_id = oci_core_vcn.vcn1.default_dhcp_options_id
  display_name               = "defaultDhcpOptions"

  // required
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  // optional
  options {
    type                = "SearchDomain"
    search_domain_names = ["millenium.oci.com"]
  }
}


resource "oci_core_default_security_list" "default_security_list" {
  manage_default_resource_id = oci_core_vcn.vcn1.default_security_list_id
  display_name               = "defaultSecurityList"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  // allow outbound udp traffic on a port range
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "17" // udp
    stateless   = true

    udp_options {
      min = 319
      max = 320
    }
  }


  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      type = 3
      code = 4
    }
  }
}




resource "oci_core_security_list" "my_security_list" {
  compartment_id = oci_identity_compartment.sub_compartment_net.id
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "sl-priv-subnet-${oci_core_vcn.vcn1.display_name}"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"
  }

  ingress_security_rules {
    protocol    = "6"  # TCP protocol number
    source      = var.app_subnet_cidr
    source_type = "CIDR_BLOCK"
    description = "Ingress rule for 1521 from app subnet to db subnet"
    tcp_options {
      min = var.port_1521
      max = var.port_1521
    }
  }

 
 ingress_security_rules {
    protocol = "6"
    source   = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 443
      max = 443
    }
  }

 ingress_security_rules {
    protocol = "6"
    source   = var.vcn_cidr
    source_type = "CIDR_BLOCK"
    tcp_options {
      min = 3389
      max = 3389
    }
  }  

  ingress_security_rules {
    protocol    = "6"  # TCP protocol number
    source      = var.app_subnet_cidr
    source_type = "CIDR_BLOCK"
    description = "Ingress rule for ssh from app subnet to db subnet"
    tcp_options {
      min = var.port_22
      max = var.port_22
    }
  }

ingress_security_rules {
    protocol    = "6"  # TCP protocol number
    source      = var.db_subnet_cidr
    source_type = "CIDR_BLOCK"
    description = "Ingress rule for ssh from db subnet to app subnet"
    tcp_options {
      min = var.port_22
      max = var.port_22
    }
  }

ingress_security_rules {
    protocol    = "6"  # TCP protocol number
    source      = var.db_subnet_cidr
    source_type = "CIDR_BLOCK"
    description = "Ingress rule for 1521 from db subnet to app subnet"
    tcp_options {
      min = var.port_1521
      max = var.port_1521
    }
  }

}
