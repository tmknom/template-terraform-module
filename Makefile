.DEFAULT_GOAL := help

# https://gist.github.com/tadashi-aikawa/da73d277a3c1ec6767ed48d1335900f3
.PHONY: $(shell grep -E '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | sed 's/://')


# Constant definitions
TERRAFORM_VERSION := 0.11.9
TERRAFORM_IMAGE := hashicorp/terraform:${TERRAFORM_VERSION}
ENVIRONMENT_VARIABLES := AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION

LINTER_IMAGES := koalaman/shellcheck tmknom/markdownlint tmknom/yamllint
FORMATTER_IMAGES := tmknom/shfmt tmknom/prettier
TERRAFORM_IMAGES := ${TERRAFORM_IMAGE} wata727/tflint tmknom/terraform-docs tmknom/terraform-landscape
DOCKER_IMAGES := ${LINTER_IMAGES} ${FORMATTER_IMAGES} ${TERRAFORM_IMAGES}

MINIMAL_DIR := ./examples/minimal
COMPLETE_DIR := ./examples/complete

# Macro definitions
define list_shellscript
	grep '^#!' -rn . | grep ':1:#!' | cut -d: -f1 | grep -v .git
endef

define terraform
	run_dir="${1}" && \
	sub_command="${2}" && \
	cd $${run_dir} && \
	docker run --rm -i -v "$$PWD:/work" -w /work \
	-e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID \
	-e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY \
	-e AWS_DEFAULT_REGION=$$AWS_DEFAULT_REGION \
	${TERRAFORM_IMAGE} $${sub_command}
endef

define check_requirement
	if ! type ${1} >/dev/null 2>&1; then \
		printf "\nNot found %s, run command\n\n" ${1}; \
		printf "    \033[36mbrew install %s\033[0m\n" ${1}; \
	fi
endef

define check_environment_variable
	key="\$$${1}" && \
	value=$$(eval "echo $${key}") && \
	if [ -z "$${value}" ]; then \
		printf "\n%s is unset, run command\n\n" $${key}; \
		printf "    \033[36mexport %s=<value>\033[0m\n" ${1}; \
	fi
endef

# Phony Targets
install: check-requirements install-images check-env ## Install requirements

install-images:
	@for image in ${DOCKER_IMAGES}; do \
		echo "docker pull $${image}" && docker pull $${image}; \
	done

check-requirements:
	@$(call check_requirement,docker)

check-env:
	@for val in ${ENVIRONMENT_VARIABLES}; do \
		$(call check_environment_variable,$${val}); \
	done

lint: lint-terraform lint-shellscript lint-markdown lint-yaml ## Lint code

lint-terraform:
	docker run --rm -v "$(CURDIR):/data" wata727/tflint
	# validate modules without variables
	terraform validate -check-variables=false
	# validate examples
	find . -type f -name '*.tf' -path "./examples/*" -not -path "**/.terraform/*" -exec dirname {} \; | sort -u | \
	xargs -I {} sh -c 'cd {} && echo {} && terraform init && terraform validate'

lint-shellscript:
	$(call list_shellscript) | xargs -I {} docker run --rm -v "$(CURDIR):/mnt" koalaman/shellcheck {}

lint-markdown:
	docker run --rm -i -v "$(CURDIR):/work" tmknom/markdownlint

lint-yaml:
	docker run --rm -v "$(CURDIR):/work" tmknom/yamllint --strict .

format: format-terraform format-shellscript format-markdown ## Format code

format-terraform:
	terraform fmt

format-shellscript:
	$(call list_shellscript) | xargs -I {} docker run --rm -v "$(CURDIR):/work" -w /work tmknom/shfmt -i 2 -ci -kp -w {}

format-markdown:
	docker run --rm -v "$(CURDIR):/work" tmknom/prettier --parser=markdown --write '**/*.md'

docs: ## Generate docs
	docker run --rm -v "$(CURDIR):/work" tmknom/terraform-docs

terraform-plan-minimal: ## Run terraform plan examples/minimal
	$(call terraform,${MINIMAL_DIR},init)
	$(call terraform,${MINIMAL_DIR},plan) | tee -a /dev/stderr | docker run --rm -i tmknom/terraform-landscape

terraform-apply-minimal: ## Run terraform apply examples/minimal
	$(call terraform,${MINIMAL_DIR},apply)

terraform-destroy-minimal: ## Run terraform destroy examples/minimal
	$(call terraform,${MINIMAL_DIR},destroy)

terraform-plan-complete: ## Run terraform plan examples/complete
	$(call terraform,${COMPLETE_DIR},init)
	$(call terraform,${COMPLETE_DIR},plan) | tee -a /dev/stderr | docker run --rm -i tmknom/terraform-landscape

terraform-apply-complete: ## Run terraform apply examples/complete
	$(call terraform,${COMPLETE_DIR},apply)

terraform-destroy-complete: ## Run terraform destroy examples/complete
	$(call terraform,${COMPLETE_DIR},destroy)


# https://postd.cc/auto-documented-makefile/
help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
