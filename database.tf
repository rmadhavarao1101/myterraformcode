resource "oci_database_db_system" "my_db_system" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.sub_compartments_db.id
  database_edition    = var.db_edition
  shape               = var.shape
  cpu_core_count      = var.cpu_core_count
  hostname            = var.hostname
  node_count          = 1            # Single node instance
  data_storage_size_in_gb = 1024      # Initial data storage size in GB
  license_model = "LICENSE_INCLUDED"
  time_zone      = var.dbtimezone
  db_home {
    database {
      admin_password = var.admin_password
      db_name        = var.db_name
      pdb_name       = var.pdb_name
      db_workload    = var.db_workload
      #time_zone      = "US/Eastern"  # Set the timezone to EST
      character_set  = "AL32UTF8"
      ncharacter_set = "AL16UTF16"
     db_backup_config {
        auto_backup_enabled     = "true"
        auto_backup_window      = "SLOT_TWELVE"
        auto_full_backup_day    = "SUNDAY"
        auto_full_backup_window = "SLOT_TWELVE"
        backup_deletion_policy  = "DELETE_AFTER_RETENTION_PERIOD"
        backup_destination_details {
          #dbrs_policy_id = <<Optional value not found in discovery>>
          #id = <<Optional value not found in discovery>>
          type = "OBJECT_STORE"
        }
        recovery_window_in_days   = "30"
        run_immediate_full_backup = "true"
      }
     }
    db_version = "19.0.0.0"
  }
  
  display_name = "db-${var.client_name}-${local.region_key}-01"
  ssh_public_keys = [
    #file("~/.ssh/ssh-key-2024-07-16.key.pub"),
    file(var.database_ssh_public_key),
   ]
  #key_details {
  #      public_key_content = var.database_ssh_public_key
  #  }
  subnet_id = oci_core_subnet.regional_subnet23.id
}
