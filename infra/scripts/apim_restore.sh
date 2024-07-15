#!/bin/bash
# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "No environment specified. Usage: $0 <environment>"
    exit 1
fi
# Get the ENVIRONMENT variable from the first argument
ENVIRONMENT=$1
# Set ENV_SHORT based on the value of ENVIRONMENT
case $ENVIRONMENT in
    uat)
        ENV_SHORT="u"
        ;;
    prod)
        ENV_SHORT="p"
        ;;
    *)
        echo "Invalid environment. Allowed values are: dev, uat, prod"
        exit 1
        ;;
esac
# Confirm the restoration process
echo "You are about to restore the API Management backup for the '$ENVIRONMENT' environment."
read -p "Are you sure you want to continue? (yes/no): " confirm
if [[ $confirm != "yes" ]]; then
    echo "Operation aborted."
    exit 0
fi
az account set -s "$(echo "$ENVIRONMENT" | awk '{ print toupper($0) }')-Esercenti"
APIM_V2_NAME="cgnonboardingportal-$ENV_SHORT-apim-v2"
APIM_V2_RG="cgnonboardingportal-$ENV_SHORT-api-rg"
BACKUP_NAME="cgnonboardingportal-$ENV_SHORT-apim-v1-backup"
STORAGE_ACCOUNT_RG="cgnonboardingportal-$ENV_SHORT-terraform-rg"
STORAGE_ACCOUNT_NAME="cgnonboardingportal${ENV_SHORT}tf"
STORAGE_ACCOUNT_CONTAINER="tfstate"
key=$(az storage account keys list \
        -g $STORAGE_ACCOUNT_RG \
        -n $STORAGE_ACCOUNT_NAME \
        --query [0].value -o tsv)
az apim restore \
--name $APIM_V2_NAME \
-g $APIM_V2_RG \
--backup-name $BACKUP_NAME \
--storage-account-name $STORAGE_ACCOUNT_NAME \
--storage-account-container $STORAGE_ACCOUNT_CONTAINER \
--storage-account-key $key \
--no-wait