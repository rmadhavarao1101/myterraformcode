provider "oci" {
#  tenancy_ocid = "mytenancyid"
#  user_ocid = "myocid"
#  private_key_path = "/Users/Rajesh.Madhavarao/Documents/terraform/myprojcode/rajesh_tf_mi_priv.pem"
#  fingerprint = "mykey"
#  region = "ca-toronto-1"

  tenancy_ocid = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region_name
}


data "oci_identity_region_subscriptions" "this" {
  tenancy_id = var.tenancy_ocid
  filter {
 name   = "region_name"
    #values = ["ca-toronto-1"]
    values = [var.region_name]
##provider.oci.region
}
}

data "oci_identity_regions" "all_regions" {}






 
