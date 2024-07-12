resource "tls_private_key" "jwt_v2" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "jwt_self_v2" {
  allowed_uses = [
    "crl_signing",
    "data_encipherment",
    "digital_signature",
    "key_agreement",
    "cert_signing",
    "key_encipherment"
  ]
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.jwt_v2.private_key_pem
  validity_period_hours = 8640
  subject {
    common_name = "apim"
  }
}