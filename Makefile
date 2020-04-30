# https://github.com/tmknom/template-terraform-module
TERRAFORM_VERSION := 0.12.24
-include Makefile.terraform

.Makefile.terraform:
	curl -sSL https://raw.githubusercontent.com/tmknom/template-terraform-module/0.2.0/Makefile.terraform -o .Makefile.terraform

MINIMAL_DIR := ./examples/minimal
COMPLETE_DIR := ./examples/complete

terraform-plan-minimal: ## Run terraform plan examples/minimal
	$(call terraform,${MINIMAL_DIR},init)
	$(call terraform,${MINIMAL_DIR},plan)

terraform-apply-minimal: ## Run terraform apply examples/minimal
	$(call terraform,${MINIMAL_DIR},apply)

terraform-destroy-minimal: ## Run terraform destroy examples/minimal
	$(call terraform,${MINIMAL_DIR},destroy)

terraform-plan-complete: ## Run terraform plan examples/complete
	$(call terraform,${COMPLETE_DIR},init)
	$(call terraform,${COMPLETE_DIR},plan)

terraform-apply-complete: ## Run terraform apply examples/complete
	$(call terraform,${COMPLETE_DIR},apply)

terraform-destroy-complete: ## Run terraform destroy examples/complete
	$(call terraform,${COMPLETE_DIR},destroy)
