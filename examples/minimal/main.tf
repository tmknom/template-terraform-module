# Module Configuration
#
# https://www.terraform.io/docs/configuration/modules.html

module "minimal" {
  source = "git::https://github.com/tmknom/template-terraform-module.git?ref=master"
}
