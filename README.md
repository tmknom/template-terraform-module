# template-terraform-module

[![Terraform Actions Status](https://github.com/tmknom/template-terraform-module/workflows/Terraform/badge.svg)](https://github.com/tmknom/template-terraform-module/actions?query=workflow%3ATerraform)
[![Shell Script Actions Status](https://github.com/tmknom/template-terraform-module/workflows/Shell%20Script/badge.svg)](https://github.com/tmknom/template-terraform-module/actions?query=workflow%3A%22Shell+Script%22)
[![Markdown Actions Status](https://github.com/tmknom/template-terraform-module/workflows/Markdown/badge.svg)](https://github.com/tmknom/template-terraform-module/actions?query=workflow%3AMarkdown)
[![YAML Actions Status](https://github.com/tmknom/template-terraform-module/workflows/YAML/badge.svg)](https://github.com/tmknom/template-terraform-module/actions?query=workflow%3AYAML)
[![JSON Actions Status](https://github.com/tmknom/template-terraform-module/workflows/JSON/badge.svg)](https://github.com/tmknom/template-terraform-module/actions?query=workflow%3AJSON)
[![GitHub tag](https://img.shields.io/github/tag/tmknom/template-terraform-module.svg)](https://registry.terraform.io/modules/tmknom/name/provider)
[![License](https://img.shields.io/github/license/tmknom/template-terraform-module.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module template following [Standard Module Structure](https://www.terraform.io/docs/modules/create.html#standard-module-structure).

## Usage

Named `terraform-<PROVIDER>-<NAME>`. Module repositories must use this three-part name format.

```shell
curl -fsSL https://raw.githubusercontent.com/tmknom/template-terraform-module/master/install | sh -s terraform-aws-sample
cd terraform-aws-sample && make install
```

## Examples

- [Minimal](https://github.com/tmknom/template-terraform-module/tree/master/examples/minimal)
- [Complete](https://github.com/tmknom/template-terraform-module/tree/master/examples/complete)

## Requirements

Write your Terraform module requirements.

## Providers

Write your Terraform module providers.

## Inputs

Write your Terraform module inputs.

## Outputs

Write your Terraform module outputs.

## Development

### Requirements

- [Docker](https://www.docker.com/)

### Configure environment variables

```shell
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=ap-northeast-1
```

### Installation

```shell
git clone git@github.com:tmknom/template-terraform-module.git
cd template-terraform-module
make install
```

### Makefile targets

```text
apply-complete                 Run terraform apply examples/complete
apply-minimal                  Run terraform apply examples/minimal
check-format                   Check format code
clean                          Clean .terraform
destroy-complete               Run terraform destroy examples/complete
destroy-minimal                Run terraform destroy examples/minimal
diff                           Word diff
docs                           Generate docs
format                         Format code
help                           Show help
install                        Install requirements
lint                           Lint code
plan-complete                  Run terraform plan examples/complete
plan-minimal                   Run terraform plan examples/minimal
release                        Release GitHub and Terraform Module Registry
upgrade                        Upgrade makefile
```

### Releasing new versions

Bump VERSION file, and run `make release`.

### Terraform Module Registry

- <https://registry.terraform.io/modules/tmknom/name/provider>

## License

Apache 2 Licensed. See LICENSE for full details.
