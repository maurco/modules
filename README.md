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

```hcl
terraform {
  backend "s3" {
    key = "production.tfstate"
  }
}
```

```bash
# required environment variables
$ export NAME="neat-system"
$ export AWS_REGION="us-east-1"
$ export AWS_PROFILE="neat"

# creates cloudformation stack for S3 bucket and DynamoDB table
$ curl -Ls https://git.io/JfdMe | sh

# initialize the backend with dynamic values
$ terraform init \
	-backend-config="bucket=$NAME" \
	-backend-config="dynamodb_table=$NAME" \
	-backend-config="region=$AWS_REGION" \
	-backend-config="profile=$AWS_PROFILE"
```
