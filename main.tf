# Resource Configuration
#
# https://www.terraform.io/docs/configuration/resources.html

resource "null_resource" "foo" {
  triggers = {
    example = "${var.example}"
  }
}
