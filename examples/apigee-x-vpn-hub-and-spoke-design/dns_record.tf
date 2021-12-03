##########################################################
# Copyright 2021 Google LLC.
# This software is provided as-is, without warranty or
# representation for any use or purpose.
# Your use of it is subject to your agreement with Google.
#
# Sample Terraform script to set up an Apigee X instance 
##########################################################

##########################################################
### Create a DNS record for the custom hostnames of the VMs in Apigee X VPC
##########################################################
resource "google_dns_record_set" "backend_1" {
  name         = "backend-1.${google_dns_managed_zone.backend_project_a_peering_zone.dns_name}"
  managed_zone = google_dns_managed_zone.backend_project_a_peering_zone.name
  type         = "A"
  ttl          = 300

  rrdatas      = [google_compute_instance.instance-01.network_interface[0].network_ip]  ##internal IP
}

resource "google_dns_record_set" "backend_2" {
  name         = "backend-2.${google_dns_managed_zone.backend_project_a_peering_zone.dns_name}"
  managed_zone = google_dns_managed_zone.backend_project_a_peering_zone.name
  type         = "A"
  ttl          = 300

  rrdatas      = [google_compute_instance.instance-02.network_interface[0].network_ip]  ##internal IP
}