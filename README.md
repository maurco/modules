# Terraform Modules

#### Usage

```hcl
module "foobar" {
  source = "github.com/maurco/modules/redirect"
}
```

#### Usage (versioned)

```hcl
module "foobar" {
  source = "github.com/maurco/modules//redirect?ref=v0.1.0"
}
```
