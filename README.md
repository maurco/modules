# Terraform Modules

#### Usage

```hcl
module "foobar" {
  source = "github.com/maurerlabs/modules/redirect"
}
```

#### Usage (versioned)

```hcl
module "foobar" {
  source = "github.com/maurerlabs/modules//redirect?ref=v0.1.0"
}
```
