# cgn-onboarding-portal-infra

A repository for collecting all terraform files needed by CGN Onboarding Portal infrastructure

## Folder Setup

```shell
$ tree
.
├── CODEOWNERS
├── README.md
└── code
    ├── README.md
    ├── adeaa_api
    │   ├── policy.xml
    │   └── swagger.json
    ├── api.tf
    ├── apim_global
    │   └── policy.xml.tpl
    ├── backend_api
    │   ├── policy.xml.tpl
    │   └── swagger.json
    ├── backoffice_api
    │   ├── policy.xml.tpl
    │   └── swagger.json
    ├── cdn.tf
    ├── database.tf
    ├── dns.tf
    ├── letsencrypt.tf
    ├── main.tf
    ├── modules
    │   ├── apim
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   └── variables.tf
    │   ├── app_function
    │   │   ├── main.tf
    │   │   └── variables.tf
    │   ├── app_service
    │   │   ├── README.md
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── cdn_endpoint
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── storage_account
    │   │   ├── README.md
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   └── subnet
    │       ├── README.md
    │       ├── main.tf
    │       ├── outputs.tf
    │       └── variables.tf
    ├── monitor.tf
    ├── network.tf
    ├── outputs.tf
    ├── public.tf
    ├── public_api
    │   ├── policy.xml
    │   └── swagger.json
    ├── redis_cache.tf
    ├── security.tf
    ├── spid_testenv.tf
    ├── spid_testenv_conf
    │   └── config.yaml.tpl
    ├── spidlogin_api
    │   ├── policy.xml
    │   ├── postacs_policy.xml.tpl
    │   └── swagger.json
    ├── storage.tf
    └── variables.tf
```

