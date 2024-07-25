locals {
  project = format("%s-%s", var.prefix, var.env_short)

  apim_name = format("%s-apim", local.project)
  # apim_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", local.project)
  apim_origins = flatten([
    [var.enable_custom_dns ? [format("https://%s", trim(data.azurerm_dns_cname_record.frontend[0].fqdn, "."))] : []],
    [format("https://%s/", "${format("%s-cdnendpoint-frontend", local.project)}.azureedge.net")],
    [var.enable_spid_test ? ["http://localhost:3000"] : []]
  ])

  spid_acs_origins = flatten([
    [var.enable_spid_test ? [format("https://%s", trim(data.azurerm_container_group.spid_testenv[0].fqdn, "."))] : []],
    [
      "https://id.lepida.it",
      "https://identity.infocert.it",
      "https://identity.sieltecloud.it",
      "https://idp.namirialtsp.com",
      "https://login.id.tim.it",
      "https://loginspid.aruba.it",
      "https://posteid.poste.it",
      "https://spid.intesa.it",
    "https://spid.register.it"]
  ])
}