# Terraform Modules

## Usage

```hcl
module "foobar" {
  source = "github.com/maurco/modules/redirect"
}
```

_or to use a versioned module:_

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
STACK_ID=
AWS_REGION=
AWS_PROFILE=

.EXPORT_ALL_VARIABLES:
.PHONY: backend init

backend:
	@curl -Ls https://raw.githubusercontent.com/maurco/modules/master/backend.sh | sh

init: backend
	@terraform init \
		-backend-config="bucket=$(STACK_ID)" \
		-backend-config="dynamodb_table=$(STACK_ID)" \
		-backend-config="region=$(AWS_REGION)" \
		-backend-config="profile=$(AWS_PROFILE)"
```
