# Backend Module

```hcl
terraform {
  backend "s3" {
    region         = "REGION"
    dynamodb_table = "STACK_NAME"
    bucket         = "STACK_NAME"
    key            = "ENVIRONMENT.tfstate"
  }
}
```

```bash
$ curl -Lso .terraform/backend.yml https://git.io/Jf2H1
$ aws cloudformation deploy \
	--template-file .terraform/backend.yml \
	--no-fail-on-empty-changeset \
	--stack-name $(STACK_NAME) \
	--profile $(AWS_PROFILE)
```

```bash
$ terraform init -backend-config="profile=$(AWS_PROFILE)"
```
