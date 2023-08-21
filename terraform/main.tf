provider "google" {
  project = local.project_id
  region  = local.region
}
resource "google_storage_bucket" "terraform-bucket-for-state" {
  name                        = "765331771100_europe_west1_bucket_tfstate"
  location                    = local.location
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
#  labels = {
 #   "environment" = "jorgebernhnardt"
  #}
}
