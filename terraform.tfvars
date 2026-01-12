
##Necessary fields required for connecting to the target OCI tenancy

user_ocid        = "ocid1.user.oc1..aaaaaaaat46xyfmsobyezpzv5nfshnjssyqtsmeosgvolh534f3l5rit7jca"          
fingerprint      = "8f:51:56:27:6b:4a:14:c3:de:cd:89:61:62:ad:8c:cb"                      
private_key_path = "/Users/Rajesh.Madhavarao/Documents/terraform/myprojcode/rajesh_tf_mi_priv.pem"     
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaa6zsrgfalz5dlstfg24aeypj6cfaoncaq4gnwcp4j5ysjvhzjy6pa"       
compartment_ocid = "ocid1.compartment.oc1..aaaaaaaatvgwoxshgt5d4vtbpinzghbcf6jmczes6qjsf5xgrjbzauwyut6a"
region_name      = "ca-toronto-1" 


##Client Name

client_name  = "mun"

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

db_name = "muncdb"
pdb_name = "test"
dbtimezone = "America/St_Johns"
##dbtimezone = "US/Eastern"
# please enter dynamically and share later via 1password #admin_password = "BEstrO0ng_#12"  		#comment this if password needs to be entered dynamically
admin_password="iribvgbxR#7G#B7"
db_workload = "OLTP"
shape = "VM.Standard.E4.Flex"
cpu_core_count = 2
db_edition = "STANDARD_EDITION"
hostname = "dbmun"  
#database_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBLGeQzcpb5WZbYhvLZde7auNPO0QMiIBi0NtPDT03OQ6vgSmx/xmJ8r87sFA8iQL1E/AfVNxITPfr+HYgepRUQT6VJmKyeUXEpG/UFdyQZx59wUzt7GRLBOYqZrg553JkIvB05iIzLLP+FZlHlyYc8+U0tr3NSZo++N2RoQdcaU8LigKoJLi0sxrrz9JMxhOSvJatW4DJVnKEK8R7cy6ZLFnFE4Z/Bskm4W8AGFzx5RWUVNMRGJFM+zguIJviHqtt0rowmxPqov7QRcIwQUwAXYMtgdIRGqMmkOz8Fwi74UaF3bAT43x5MuMkq+nkKVQfTcGmsBfPf3iqizamPD1XVbX1RcNvKlPa6xAIto0hPXv4YurgLUQOlQbXuoGiADC/+X/+k8ExcpfSijw0LwQGU4Q4o44vZdzDQeASqkojEIBojf88dTIR5SUICtGg/KmXrANK/Grjne6qwvtxZeWhGEhAQHHOuTQrI9h3Xk7uerMh5E+6Bfp+MXTyX8kByhk= Rajesh.Madhavarao@Eclipsyss-MacBook-Pro.local"
database_ssh_public_key = "~/.ssh/mun_db.pub"



##Application server Parameteters

# please enter dynamically and share later via 1password #app_admin_password = "BEstrO0ng_#12"           #comment this if password needs to be entered dynamically
app_admin_password = "xzrDc3-N#XPPC-h"
instance_shape = "VM.Standard.E4.Flex"
instance_ocpus = 1
#windows_image_ocid = "ocid1.image.oc1.ca-toronto-1.aaaaaaaarp6kviuuh26pwjkorwmhgj6zypdnp47tt2a5kxkljy6p3k4g4rla"
windows_image_ocid = "ocid1.image.oc1.ca-toronto-1.aaaaaaaazlfbwlt2tvrigm6z4ovko6ngfz2bln5xuos6vyfpo5dvjtjillga"
instance_memory_gb = 16

##Bastion Host

#bastion_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6cvrbqY/g9zplZivxj2F93YZ9UJ8y6MIo4X5IJRQ5kPg3Nmny6EB0n9bsM/FQkXKyS+YoZK+xb8A+ccCpG4dLMEQ0mzi/7H3e2JD+y4EF2aMcvWBxus3KWYvZ9yRJZAhYlxSQIJUPdCTw+vzqclvIojOSaMZgPkxjxMnFRxb2VeMpzv9ZxSP4hvFWx/9RNIqDr1z1LKTl4aQ4wps9tD26Kz6G3K2aoE49/QQyPRRnifOmSzwr4woURXUYI7GfBfOf04ac9ZyLKNZ+XdzShm0OhPHwqMst6MXPdDid9fMg+6r+pC0FkhX8pO2jTy67AonNsKA0UX3nPehhfuJHSwyJ Rajesh.Madhavarao@Eclipsyss-MacBook-Pro.local"
    
