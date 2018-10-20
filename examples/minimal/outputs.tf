# Output Configuration
#
# https://www.terrafsorm.io/docs/configuration/outputs.html

output "null_resource_id" {
  value       = "${module.minimal.null_resource_id}"
  description = "An arbitrary value that changes each time the resource is replaced."
}

output "example_value" {
  value       = "${module.minimal.example_value}"
  description = "Example variable."
}
