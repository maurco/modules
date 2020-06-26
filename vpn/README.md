# VPN Module

```hcl
module "foobar" {
  source        = "github.com/maurco/modules/vpn"
  zone_id       = ""
  vpc_id        = ""
  subnet_id     = ""
  domain        = ""
  instance_type = ""
  public_key    = file("")
}
```
