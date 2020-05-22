# Backend Module

```bash
$ curl -Lso backend.yml https://git.io/Jf2H1
$ aws cloudformation deploy \
	--no-fail-on-empty-changeset \
	--template-file backend.yml \
	--stack-name $(STACK_NAME) \
	--profile $(AWS_PROFILE)
```

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