# CDN Module

```hcl
module "foobar" {
  source          = "github.com/maurco/modules/cdn"
  zone_id         = ""
  certificate_arn = ""
  domain          = ""
  trusted_signers = [""]
}
```
