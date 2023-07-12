data "google_compute_network" "redis-network" {
  name    = var.name_reserved_ip_range
  project = var.host_project_id
}
resource "google_project_service" "redisapi" {
  project = var.project_id
  service = "redis.googleapis.com"
}
resource "google_redis_instance" "gcp_redis" {
  depends_on              = [google_project_service.redisapi]
  name                    = var.redis_name
  memory_size_gb          = var.memory_size_gb
  authorized_network      = var.authorized_network
  redis_configs           = var.redis_configs
  redis_version           = var.redis_version
  tier                    = var.tier
  region                  = var.region
  project                 = var.project_id
  auth_enabled            = var.auth_enabled
  transit_encryption_mode = var.transit_encryption_mode
  connect_mode            = var.connect_mode
  reserved_ip_range       = data.google_compute_network.redis-network.id
}