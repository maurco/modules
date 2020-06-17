# Backend Module

```hcl
terraform {
  backend "s3" {
    key = "ENVIRONMENT.tfstate"
  }
}
```

```bash
$ export STACK_NAME="..."
$ export AWS_REGION="..."
$ export AWS_PROFILE="..."
$ curl -Ls https://git.io/Jfd6V | sh
$ terraform init \
	-backend-config="bucket=$STACK_NAME" \
	-backend-config="dynamodb_table=$STACK_NAME" \
	-backend-config="region=$AWS_REGION" \
	-backend-config="profile=$AWS_PROFILE"
```
