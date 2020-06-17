# Static Module

```hcl
module "foobar" {
  source = "github.com/maurco/modules/static"
  zone_id = ""
  certificate_arn = ""
  domain = ""
  aliases = [""]
  app_page = ""
  not_found_page = "/404.html"
  error_page = "/500.html"
}
```
