# Redirect Module

```hcl
module "foobar" {
  source = "github.com/maurco/modules/redirect"
  zone_id = ""
  certificate_arn = ""
  to = ""
  from_domain = ""
  from_subdomains = [""]
}
```
