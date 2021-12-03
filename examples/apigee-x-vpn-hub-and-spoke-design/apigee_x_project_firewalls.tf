##########################################################
# Copyright 2021 Google LLC.
# This software is provided as-is, without warranty or
# representation for any use or purpose.
# Your use of it is subject to your agreement with Google.
#
# Sample Terraform script to set up an Apigee X instance 
##########################################################

#######################################################################
### Create firewall rules
#######################################################################
resource "google_compute_firewall" "apigee_x_vpc_allow_ssh" {
  project     = google_project.apigee_x_project.project_id
  name        = "apigee-x-vpc-allow-ssh"
  network     = google_compute_network.apigee_x_vpc.id
  direction   = "INGRESS"
  priority    = 1000
  description = "Creates firewall rile targeting tagged test instances"

  allow {
    protocol = "tcp"
    ports    = ["22"] 
  }
  
  source_ranges = ["0.0.0.0/0"]

  target_tags   = ["apigee-x-vpc-allow-ssh"]
}

resource "google_compute_firewall" "apigee_x_vpc_allow_icmp" {
  project     = google_project.apigee_x_project.project_id
  name        = "apigee-x-vpc-allow-icmp"
  network     = google_compute_network.apigee_x_vpc.id
  direction   = "INGRESS"
  priority    = 1000
  description = "Creates firewall rile targeting tagged test instances"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags   = ["apigee-x-vpc-allow-icmp"]
}
