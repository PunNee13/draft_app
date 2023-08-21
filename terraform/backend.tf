terraform {
 backend "gcs" {
   bucket  = "765331771100_europe_west1_bucket_tfstate"
   prefix  = "terraform/state"
 }
}