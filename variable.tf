

variable "client_name" {
type = string
# default = "sony"      										## client name
 }

variable "region_name" {
type = string
default = "ca-toronto-1"      									##region name
 }

#variable "availability_domain" {
#  default = "BahF:CA-TORONTO-1-AD-1"
#    }  


variable "private_key_path" {  										##private key path
  type = string
}


variable "user_ocid" {  										##User OCID
  type = string
}

variable "compartment_ocid" {
type = string
#default = "ocid1.compartment.oc1..aaaaaaaaskpl4e64lckhvjyzpn2amztpnuqq4mo2gjag6si3272kgdzcnwja"        ##parent compartment OCID
}

variable "fingerprint" {										##fingerprint	
  type = string
}


variable "tenancy_ocid" {
type = string
#default = "ocid1.tenancy.oc1..aaaaaaaaqkfafm7ykyzmszzdoe3hvimyx5dszcvg7fiju4tjrkkqt7crdn7a"       	##tenancy OCID
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string							
#  default     = "10.0.0.0/16"                                           		                ##VCN CIDR
}

variable "web_subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
#  default     = "10.0.1.0/24"                                                                          ##web subnet CIDR
}


variable "app_subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string 
#  default     = "10.0.2.0/24"                                                                          ##app subnet CIDR
}

variable "db_subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
#  default     = "10.0.3.0/24"                                                                           ##db subnet CIDR
}

variable "create_service_gateway" {
  description = "whether to create a service gateway. If set to true, creates a service gateway."
  default     = true
  type        = bool
}

variable "label_prefix" {
  description = "a string that will be prepended to all resources"
  type        = string
  default     = "none"
}

variable "freeform_tags" {
  description = "simple key-value pairs to tag the created resources using freeform OCI Free-form tags."
  type        = map(any)
  default = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-modules/vcn/oci"
  }
}

variable "defined_tags" {
  description = "predefined and scoped to a namespace to tag the resources created using defined tags."
  type        = map(string)
  default     = null
}


variable "service_gateway_display_name" {
  description = "(Updatable) Name of Service Gateway. Does not have to be unique."
  type        = string
  default     = "service-gateway"

  validation {
    condition     = length(var.service_gateway_display_name) > 0
    error_message = "The service_gateway_display_name value cannot be an empty string."
  }
}


#####Variables for security rule#####

variable "port_1521" {
  description = "Port 1521 for Oracle Database"
  type        = number
  default     = 1521
}

variable "port_22" {
  description = "Port 22 for SSH"
  type        = number
  default     = 22
}

variable "port_443" {
  description = "Port 443 for https"
  type        = number
  default     = 443
}

variable "port_3389" {
  description = "Port 3389 for rdp"
  type        = number
  default     = 3389
}


#####Database parameters#####


variable "dbtimezone" {
  description = "The timezone of the database"
  type        = string
#  default     = "US/Eastern"
}


variable "db_name" {
  description = "The name of the database"
  type        = string
#  default     = "sony"
}

variable "pdb_name" {
  description = "The name of the Pluggable Database (PDB)"
  type        = string
#  default     = "pdbsong"
}

variable "admin_password" {
  description = "The administrator password for the database"
  type        = string
  sensitive   = true
#  default     = "BEstrO0ng_#12"
}

variable "db_workload" {
  description = "The database workload type (OLTP or DSS)"
  type        = string
#  default     = "OLTP"
}

variable "shape" {
  description = "The shape of the database instance"
  type        = string
#  default     = "VM.Standard.E4.Flex"
}

variable "cpu_core_count" {
  description = "The number of OCPUs for the database instance"
  type        = number
#  default     = 2
}

variable "db_edition" {
  description = "The database edition (STANDARD_EDITION, ENTERPRISE_EDITION, etc.)"
  type        = string
#  default     = "STANDARD_EDITION"
}


variable "hostname" {
  description = "The hostname for the DB system"
  type        = string
#  default     = "dbsony"	
}

variable "database_ssh_public_key" {
#default = "~/.ssh/ssh-key-2024-07-16.key.pub"
}


###### Application server Variables ######

variable "app_admin_password" {
  description = "The administrator password for the Windows instance"
  type        = string
  sensitive   = true
#  default     = "BEstrO0ng_#12"
}

variable "instance_shape" {
  description = "The shape of the instance"
  type        = string
#  default     = "VM.Standard.E4.Flex"
}

variable "instance_display_name" {
  description = "The display name of the instance"
  type        = string
  default     = "my_windows_instance"
}

variable "instance_ocpus" {
  description = "The number of OCPUs for the instance"
  type        = number
#  default     = 2
}

variable "instance_memory_gb" {
  description = "The amount of memory in GB for the instance"
  type        = number
#  default     = 16
}

variable "windows_image_ocid" {
  description = "The OCID of the Windows image to use"
  type        = string
#  default     = "ocid1.image.oc1.ca-toronto-1.aaaaaaaarp6kviuuh26pwjkorwmhgj6zypdnp47tt2a5kxkljy6p3k4g4rla"
}

######## Basion service details ###########


#variable "bastion_ssh_public_key" { 
#default = "~/.ssh/ssh-key-2024-07-16.key.pub"
#}



#variable "session_target" {
#type = string
#}
