# Redirect Module

```hcl
module "foobar" {
  source = "github.com/maurerlabs/modules//redirect?ref=v0.1.0"
  zone_id = ""
  from_domain = ""
  to_domain = ""
  protocol = "https"
}
```
