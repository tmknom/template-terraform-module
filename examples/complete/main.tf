# Module Configuration
#
# https://www.terraform.io/docs/configuration/modules.html

module "complete" {
  source = "git::https://github.com/tmknom/template-terraform-module.git?ref=master"

  example = "complete"
}
