##########################################################
# Copyright 2021 Google LLC.
# This software is provided as-is, without warranty or
# representation for any use or purpose.
# Your use of it is subject to your agreement with Google.
#
# Sample Terraform script to set up an Apigee X instance 
##########################################################

#######################################################################
### Create 2 subnets
#######################################################################
resource "google_compute_subnetwork" "apigee_x_project_subnet1" {
  project                  = google_project.apigee_x_project.project_id
  name                     = "${var.subnet_1}-subnet"
  region                   = var.subnet_1
  network                  = google_compute_network.apigee_x_vpc.id
  ip_cidr_range            = "10.0.1.0/24"
}

resource "google_compute_subnetwork" "apigee_x_project_subnet2" {
  project                  = google_project.apigee_x_project.project_id
  name                     = "${var.subnet_2}-subnet"
  region                   = var.subnet_2
  network                  = google_compute_network.apigee_x_vpc.id
  ip_cidr_range            = "10.0.2.0/24"
}