# cgn-onboarding-portal-infra

A repository for collecting all terraform files needed by CGN Onboarding Portal infrastructure

## Folder Setup

```shell
$ tree
.
├── CODEOWNERS
├── README.md
├── code
│   ├── README.md
│   ├── cdn.tf
│   ├── database.tf
│   ├── main.tf
│   ├── storage.tf
│   ├── variables.tf
│   └── vnet.tf
├── modules
│   ├── module_x
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── provider.tf # gitignored
│   │   └── variables.tf
└── vars
    ├── dev.tf
    ├── main.tf
    ├── prod.tf
    └── provider.tf
```

## Terraform Cloud Workspace Overview

There are 3 workspaces in terraform cloud:

* cgn-onboarding-portal-dev
* cgn-onboarding-portal-prod
* cgn-onboarding-portal-vars

dev and prod workspaces are triggered only when the modules and core folders changes and when the source workspace vars changes are applied.

vars workspace is automatically triggered and applied only for changes in the vars directory.


## Terraform Cloud Environment Configuration

Manually add these environment variables to the dev and prod terraform cloud workspaces:

* ARM_SUBSCRIPTION_ID
* ARM_TENANT_ID
* ARM_CLIENT_ID
* ARM_CLIENT_SECRET

In the vars workspace add the TFE_TOKEN environment variable needed to configure terraform cloud variables.

## Local Terraform Validate

Due to an issue with the azurerm provider features map is always required.

Create in each module folder a provider.tf file

```hcl
provider "azurerm" {
  features {}
}
```

with something like

```bash
for d in modules/*/; do
  cat <<EOT > "$d/provider.tf"
provider "azurerm" {
  features {}
}
EOT
done
```

this file is in git ignore because is bad practice creating a provider inside terraform modules.
