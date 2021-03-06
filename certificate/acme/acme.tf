resource "acme_registration" "main" {
  email_address   = var.email
  account_key_pem = tls_private_key.reg.private_key_pem
}

resource "acme_certificate" "main" {
  certificate_request_pem = tls_cert_request.main.cert_request_pem
  account_key_pem         = acme_registration.main.account_key_pem

  dns_challenge {
    provider = "route53"
  }
}
