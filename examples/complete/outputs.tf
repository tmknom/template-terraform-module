output "null_resource_id" {
  value       = "${module.complete.null_resource_id}"
  description = "An arbitrary value that changes each time the resource is replaced."
}

output "example_value" {
  value       = "${module.complete.example_value}"
  description = "Example variable."
}
