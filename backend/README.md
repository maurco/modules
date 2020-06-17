# Backend Module

```hcl
terraform {
  backend "s3" {
    region = "REGION"
    key    = "ENVIRONMENT.tfstate"
  }
}
```

```bash
$ curl -Ls https://git.io/Jfd6V | sh
```

```bash
$ terraform init \
	-backend-config="bucket=$(STACK_NAME)" \
	-backend-config="dynamodb_table=$(STACK_NAME)" \
	-backend-config="profile=$(AWS_PROFILE)"
```
