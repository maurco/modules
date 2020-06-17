# Redirect Module

```hcl
module "foobar" {
  source = "github.com/maurco/modules/redirect"
  zone_id = ""
  certificate_arn = ""
  from_domain = ""
  to_protocol = "https"
  to_domain = ""
  aliases = [""]
}
```
