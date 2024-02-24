# Output Values
# https://www.terraform.io/docs/language/values/outputs.html

output "istio_gateway_ip" {
  description = "The IP address of the Istio Gateway"
  value       = google_compute_global_address.istio_gateway.address
}
