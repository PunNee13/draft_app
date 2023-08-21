##### Creating Cloud Run #####

resource "google_cloud_run_service" "cloud_run" {
  name     = var.cloud_run.cloud_run_name
  project  = var.cloud_run.project
  location = var.cloud_run.location

  template {
    spec {
      containers {
        image = var.cloud_run.container_image
        ports {
          container_port = var.cloud_run.container_port
        }
        dynamic "env" {
          for_each = {for index,env in var.cloud_run.environment_variables: env.name => env}
          content {
              name = env.value.name
              value = env.value.value
          }
        }
        resources {
          limits = {
            cpu    = var.cloud_run.cpu_limit
            memory = var.cloud_run.memory_limit
          }
        }
      }
      service_account_name = var.cloud_run.service_account_name
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale"  = var.cloud_run.min_instances
        "autoscaling.knative.dev/maxScale"  = var.cloud_run.max_instances
      }
    }
  }
  metadata {
    annotations = {
        "run.googleapis.com/ingress" = var.cloud_run.internal_or_external
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  
}

###### Cloud Run IAM Binding #######

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_service.cloud_run.location
  project  = google_cloud_run_service.cloud_run.project
  service  = google_cloud_run_service.cloud_run.name
  role     = var.cloud_run.cloud_run_role
  members  = var.cloud_run.members
}