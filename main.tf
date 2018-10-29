resource "null_resource" "foo" {
  triggers = {
    example = "${var.example}"
  }
}
