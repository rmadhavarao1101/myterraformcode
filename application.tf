
resource "oci_core_instance" "my_windows_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.sub_compartment_app.id
  shape               = var.instance_shape
  display_name        = "app-${var.client_name}-${local.region_key}-01"

  create_vnic_details {
    subnet_id = oci_core_subnet.regional_subnet22.id
    assign_public_ip = false 
 }

  source_details {
    source_type = "image"
    source_id   = var.windows_image_ocid
  }

  shape_config {
    ocpus = var.instance_ocpus
    memory_in_gbs = var.instance_memory_gb
  }

  metadata = {
    app_admin_password = var.admin_password
  }

  agent_config {
    is_monitoring_disabled = false
    is_management_disabled = false
  }

  # Secure Boot + volume encryption
#  launch_options {
#    firmware                             = "UEFI_64"
#    is_pv_encryption_in_transit_enabled = true
#    network_type                         = "VFIO"
#  }


launch_options {
  boot_volume_type                     = "PARAVIRTUALIZED"
  network_type                         = "PARAVIRTUALIZED"
  is_pv_encryption_in_transit_enabled  = true
}


  # TPM + Measured Boot (required for Credential Guard)
  platform_config {
    type                              = "AMD_VM"   # or INTEL_VM depending on shape
    is_trusted_platform_module_enabled = true
    is_measured_boot_enabled           = true
    is_secure_boot_enabled             = true
  }


  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

