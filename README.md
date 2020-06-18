# Terraform Modules

## Usage

```hcl
module "foobar" {
  source = "github.com/maurco/modules/redirect"
}
```

#### Versioned

```hcl
module "foobar" {
  source = "github.com/maurco/modules//redirect?ref=v0.1.0"
}
```

## S3 Backend

> `main.tf`
```hcl
terraform {
  backend "s3" {
    key = "production.tfstate"
  }
}
```

> `Makefile`
```make
NAME=
AWS_REGION=
AWS_PROFILE=
ENVIRONMENT=

.EXPORT_ALL_VARIABLES:
.PHONY: init backend

init: backend
	@cd $(ENVIRONMENT) && terraform init \
		-backend-config="bucket=$(NAME)" \
		-backend-config="dynamodb_table=$(NAME)" \
		-backend-config="region=$(AWS_REGION)" \
		-backend-config="profile=$(AWS_PROFILE)"

backend:
	@curl -Ls https://git.io/JfdMe | sh
```
