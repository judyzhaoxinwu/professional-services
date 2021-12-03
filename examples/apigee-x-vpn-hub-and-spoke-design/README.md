# Apigee X VPN Hub and Spoke Design
The purspose is to showcase that multiple backends can use Cloud VPN and DNS peering to connect to the Apigee X VPC and then connect to the Apigee Runtime. Please check the IAM permissions for creating all the required resources but users with `Organization Admin` role will be suffient.

## Components

### GCP Project

`apigee_x_project.tf` is for creating a GCP project and enabling all the necessary GCP APIs. 

```
compute.googleapis.com
apigee.googleapis.com
servicenetworking.googleapis.com
cloudkms.googleapis.com
dns.googleapis.com
```

### Apigee Org

`apigee_x_organization.tf` is for creating the Apigee Runtime and environments in the GCP managed service environment. Be default, the name/ID of the organization will have the same name/ID as the GCP project. 


## Networking

### VPCs 
`apigee_x_project_vpc.tf` sets up a VPC for the GCP project that the Apigee runtime can connect to via VPC peering. It also creates a VPC subnet that is reserved for Apigee runtime with /16. Please note that the VPC currently only has one subnet and when more subnets are needed later, please do not overlap the IP ranges.

`apigee_x_project_subnets.tf` creates two subnets (us-east1 and us-west2) within the Apigee VPC and one VMs in each zone for testing the connectivity. Please note that Apigee Runtime requires ssh and icmp connections. 

### VPN Gateways
In order to connect to other VPCs from the Apigee VPC, HA Tunnels are needed in this case. `apigee_x_project_router_vpn.tf` sets up a Cloud Router and VPN gateway in each zone for the Apigee X VPC. `backend_project_a.tf` creates a GCP project and a VPC for the Backend a. `backend_project_a_vpn_subnet1.tf` and `backend_project_a_vpn_subnet2.tf` will create th VPN gateway interfaces, tunnels and router peering.

_If the connections are established, you will be able to ping the VM in the same zone from the other VPC._


### DNS Peering
DNS peering is enabled between Apigee X VPC and backend VPCs so that DNS lookup can be performed in the backend VPC for the coming request in the Apigee VPC. 

`dns_peering.tf` sets up a peering zone in Apigee X VPC so that it can look up internal DNS name or custom hostnames of the VMs in backend VPC and setting up a peering zone in backend VPC can allow lookups in the opposite direction.

_If the VMs have custom hostnames, you need to add a DNS record in the private zone as in `dns_record.tf`_

### Backends
Backend projects are created with instances, VPC and subnets for demonstrating the connection among Apigee managed runtime, Apigee VPC and backend VPC.


## Setup

Please edit the needed variables in `terraform.tfvars`. Some of them are defined with default values in `variables.tf`.

Once Terraform is installed, you can perform the commands below in the root of this folder:
```
terraform init
terraform plan
terraform apply
```

Recommended order is
```
main.tf
apigee_x_project.tf
backend_project_a.tf
apigee_x_project_vpc.tf
apigee_x_project_subnets.tf
apigee_x_project_organization.tf
apigee_x_project_router_vpn.tf
backend_project_a_vpn_subnet1.tf
backend_project_a_vpn_subnet2.tf
dns_peering.tf
dns_record.tf
apigee_x_project_instances.tf
apigee_x_project_firewalls.tf
```