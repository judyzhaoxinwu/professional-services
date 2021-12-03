##########################################################
# Copyright 2021 Google LLC.
# This software is provided as-is, without warranty or
# representation for any use or purpose.
# Your use of it is subject to your agreement with Google.
#
# Sample Terraform script to set up an Apigee X instance 
##########################################################

##########################################################
### Create Cloud DNS Peering zones for Apigee x VPC and backend project a VPC
##########################################################
resource "google_dns_managed_zone" "backend_project_a_peering_zone" {
  project     = google_project.apigee_x_project.project_id
  name        = "backend_project_a_peering_zone"
  dns_name    = var.peering_zone_domain_a
  description = "For DNS peering in backend project a"
  visibility  = "private"
  
  private_visibility_config {
    networks {
      network_url = google_compute_network.apigee_x_vpc.id
    }
  }
  
  peering_config {
    target_network {
      network_url = google_compute_network.backend_project_a_vpc.id
    }
  }
}

resource "google_dns_managed_zone" "apigee_x_project_peering_zone" {
  project     = google_project.backend_project_a.project_id
  name        = "backend-project-a-peering-zone"
  dns_name    = var.peering_zone_domain_a
  description = "Peering zone for apigee x project"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.backend_project_a_vpc.id
    }
  }

  peering_config {
    target_network {
      network_url = google_compute_network.apigee_x_vpc.id
    }
  }
}