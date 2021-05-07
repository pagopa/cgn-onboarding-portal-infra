<policies>
  <inbound>
    <base />
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true" >
      <openid-config url="${openid_config_url}" />
      <audiences>
        <audience>${audience}</audience>
      </audiences>
    </validate-jwt>
    <set-header name="X-CGN-USER-ROLE" exists-action="override">
      <value>ROLE_ADMIN</value>
    </set-header>
  </inbound>
  <outbound>
    <base />
  </outbound>
</policies>
