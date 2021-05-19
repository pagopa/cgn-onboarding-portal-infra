<policies>
  <inbound>
    <base />
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401"  require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true">
      <issuer-signing-keys>
        <key certificate-id="jwt-spid-crt" />
      </issuer-signing-keys>
      <issuers>
        <issuer>SPID</issuer>
      </issuers>
    </validate-jwt>

    <send-request mode="new" response-variable-name="tokenstate" timeout="20" ignore-error="true">
      <set-url>${hub_spid_login_url}/introspect</set-url>
      <set-method>POST</set-method>
      <set-header name="Content-Type" exists-action="override">
        <value>application/x-www-form-urlencoded</value>
      </set-header>
      <set-body>@($"token={(string)context.Request.Headers.GetValueOrDefault("Authorization","").Split(' ').Last()}")</set-body>
    </send-request>

    <choose>
      <!-- Check active property in response -->
      <when condition="@((bool)((IResponse)context.Variables["tokenstate"]).Body.As<JObject>()["active"] == false)">
      <!-- Return 401 Unauthorized with http-problem payload -->
        <return-response response-variable-name="existing response variable">
          <set-status code="401" reason="Unauthorized" />
          <set-header name="WWW-Authenticate" exists-action="override">
            <value>Bearer error="invalid_token"</value>
          </set-header>
        </return-response>
      </when>
    </choose>
    <set-header name="X-CGN-USER-ROLE" exists-action="override">
      <value>ROLE_MERCHANT</value>
    </set-header>
  </inbound>
  <outbound>
    <base />
  </outbound>
</policies>
