resource "tls_private_key" "reg" {
  algorithm = "RSA"
}

resource "tls_private_key" "main" {
  algorithm = "RSA"
}

resource "tls_cert_request" "main" {
  private_key_pem = tls_private_key.main.private_key_pem
  dns_names       = [local.domain, "*.${local.domain}"]
  key_algorithm   = "RSA"

  subject {
    common_name = local.domain
  }
}
