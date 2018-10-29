output "null_resource_id" {
  value       = "${null_resource.foo.id}"
  description = "An arbitrary value that changes each time the resource is replaced."
}

output "example_value" {
  value       = "${var.example}"
  description = "Example variable."
}
