
##Necessary fields required for connecting to the target OCI tenancy

user_ocid        = "ocid1.user.oc1..mydummy"          
fingerprint      = "8f:51:56:27:6b:mydummy"                      
private_key_path = "/Users/Rajesh.Madhavarao/Documents/terraform/myprojcode/rajesh_tf_mi_priv.pem"     
tenancy_ocid     = "ocid1.tenancy.oc1..mydummy"       
compartment_ocid = "ocid1.compartment.oc1..mydummy"
region_name      = "ca-toronto-1" 


##Client Name

client_name  = "demo"

##Network details

##VCN CIDR Range
vcn_cidr = "172.16.40.0/21" 

##Web subnet CIDR Range
web_subnet_cidr = "172.16.40.0/22"

##App subnet CIDR Range 
app_subnet_cidr = "172.16.44.0/23"  

##Db subnet CIDR Range
db_subnet_cidr = "172.16.46.0/23" 

##Database Parameters

db_name = "democdb"
pdb_name = "test"
dbtimezone = "America/St_Johns"
##dbtimezone = "US/Eastern"
# please enter dynamically and share later via 1password #admin_password = "dummypass"  		#comment this if password needs to be entered dynamically
admin_password="dummypass"
db_workload = "OLTP"
shape = "VM.Standard.E4.Flex"
cpu_core_count = 2
db_edition = "STANDARD_EDITION"
hostname = "dbmun"  
#database_ssh_public_key = "ssh-rsa dummykey Rajesh.Madhavarao@Eclipsyss-MacBook-Pro.local"
database_ssh_public_key = "~/.ssh/demo_db.pub"



##Application server Parameteters

# please enter dynamically and share later via 1password #app_admin_password = "dummypass"           #comment this if password needs to be entered dynamically
app_admin_password = "dummy"
instance_shape = "VM.Standard.E4.Flex"
instance_ocpus = 1
#windows_image_ocid = "ocid1.image.oc1.ca-toronto-1.dummyocid"
windows_image_ocid = "ocid1.image.oc1.ca-toronto-1.dummyocid"
instance_memory_gb = 16

##Bastion Host

#bastion_ssh_public_key = "ssh-rsa dummykey Rajesh.Madhavarao@Eclipsyss-MacBook-Pro.local"
    
