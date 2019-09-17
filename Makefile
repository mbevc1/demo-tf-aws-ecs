.PHONY: help
.DEFAULT: help
ifndef VERBOSE
.SILENT:
endif

NO_COLOR=\033[0m
GREEN=\033[32;01m
YELLOW=\033[33;01m
RED=\033[31;01m

SHELL = bash
CWD := $(shell pwd -P)

DONE = echo -e "\e[31m✓\e[0m \e[33m$@\e[0m \e[32mdone\e[0m"

help:: ## Show this help
	echo -e "\nDemo\033[32m -> \033[0m:\033[35mTerraform\033[0m:\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean-up all
	echo -e "==> $(GREEN)Deleting plugins, state and plans$(NO_COLOR)"
	-rm -rf .terraform terraform.tfstate* *.tfplan
	$(DONE)

.PHONY: apply
apply: ## Terraform apply
	echo -e "==> $(GREEN)Terraform apply$(NO_COLOR)"
	terraform init
	terraform plan -out terraform.tfplan
	terraform apply -auto-approve terraform.tfplan
	$(DONE)

.PHONY: destroy
destroy: ## Terraform destroy
	echo -e "==> $(GREEN)Terraform destroy$(NO_COLOR)"
	terraform destroy -auto-approve
	$(DONE)

.PHONY: fmt
fmt: ## Terraform format
	echo -e "==> $(GREEN)Terraform fmt$(NO_COLOR)"
	terraform fmt
	$(DONE)

.PHONY: validate
validate: ## Terraform validate
	echo -e "==> $(GREEN)Terraform validate$(NO_COLOR)"
	terraform validate
	$(DONE)
