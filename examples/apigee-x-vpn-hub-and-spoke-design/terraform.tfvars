/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Rename this file to terraform.tfvars and update the below variables
gcp_org_id = "Your Org ID"
gcp_billing_id= "Your Billing Account ID"
peering_zone_domain_a = "" ##put in the suffix of the DNS you will use for naming the custom hostnames for your backend VMs or GKE clusters. E.g., dev.example.com

###the variables below have default values defined in variables.tf. Please put in new values here if you don't want to use the default values.
# subnet_1 = ""
# subnet_2 = ""
# apigee_x_project_subnet = ""
# cidr_mask =

# apigee_x_project_router1_asn = 
# backend_project_a_router1_asn = 
# apigee_x_project_router2_asn = 
# backend_project_a_router2_asn = 
