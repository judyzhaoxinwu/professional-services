##########################################################
# Copyright 2021 Google LLC.
# This software is provided as-is, without warranty or
# representation for any use or purpose.
# Your use of it is subject to your agreement with Google.
#
# Sample Terraform script to set up an Apigee X instance 
##########################################################

#######################################################################
### Create 2 test instances in Apigee X project for each zone
#######################################################################
resource "google_compute_instance" "instance-01" {
  name         = "instance-01"
  project      = google_project.apigee_x_project.project_id
  machine_type = "n1-standard-1"
  zone         = "${var.subnet_1}-b"

  tags     = ["apigee-x-vpc-allow-ssh", "apigee-x-vpc-allow-icmp"]

  hostname = "instance-01.${var.peering_zone_domain_a}"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.apigee_x_vpc.id
    subnetwork = google_compute_subnetwork.apigee_x_project_subnet1.id

    access_config {
      
    }
  }

}

resource "google_compute_instance" "instance-02" {
  name         = "instance-02"
  project      = google_project.apigee_x_project.project_id
  machine_type = "n1-standard-1"
  zone         = "${var.subnet_2}-a"

  tags = ["apigee-x-vpc-allow-ssh", "apigee-x-vpc-allow-icmp"]

  hostname = "instance-02.${var.peering_zone_domain_a}"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.apigee_x_vpc.id
    subnetwork = google_compute_subnetwork.apigee_x_project_subnet1.id

    access_config {

    }
  }
}