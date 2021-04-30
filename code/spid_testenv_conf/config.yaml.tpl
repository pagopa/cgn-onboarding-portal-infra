---
# Identity Provider (IdP)
#########################

# The base URL where spid-testenv2 is reachable at.
base_url: "${base_url}"

# Key and certificate used to sign SAML messages.
key_file: "./conf/idp.key"
cert_file: "./conf/idp.crt"

# Service Providers
###################

# You can configure multiple Service Provider by specifying their XML metadata,
# using different sources.
metadata:
  remote:
    - "${service_provider_metadata_url}"


# Application configuration
###########################

# Whether to enable debug mode. When enabled, the log will be more verbose.
debug: true

# Bind the webserver to the specified IP address (use 0.0.0.0 for all interfaces).
host: "0.0.0.0"
# Port the webserver listens on.
port: 8088

# Whether to enable HTTPS.
https: false

# The TLS key and certificate used for HTTPS, required if HTTPS is enabled.
# https_key_file: "path/to/key"
# https_cert_file: "path/to/cert"

# File holding the identities of test users.
# It will be automatically created if it doesn't exist.
users_file: "conf/users.json"

# PostgreSQL database holding the identities of test users.
# If specified, it will override the "user_file" parameter.
# The required tables will be automatically created if they don't exist.
# users_db: 'postgresql+psycopg2://postgres:@localhost:5432/exampledb'

# If enabled, allows to add new users from the UI.
can_add_user: true

# Whether to enable the UI to handle the data in the database.
database_admin_interface: true

# If enabled, allows the user to manipulate the response from the Identity Provider.
# Useful to simulate errors in the response.
show_response_options: true
