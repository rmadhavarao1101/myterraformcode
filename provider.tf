provider "oci" {
#  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaqkfafm7ykyzmszzdoe3hvimyx5dszcvg7fiju4tjrkkqt7crdn7a"
#  user_ocid = "ocid1.user.oc1..aaaaaaaa44yre4fqhotsfvchi6r35oa5ielymjlpbrim5v7lkjonli7wriqa"
#  private_key_path = "/Users/Rajesh.Madhavarao/Documents/terraform/myprojcode/rajesh_tf_mi_priv.pem"
#  fingerprint = "8f:51:56:27:6b:4a:14:c3:de:cd:89:61:62:ad:8c:cb"
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






 
