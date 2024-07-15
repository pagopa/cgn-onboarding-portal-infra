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
        echo "Invalid environment. Allowed values are: uat, prod"
        exit 1
        ;;
esac

az account set -s "$(echo "$ENVIRONMENT" | awk '{ print toupper($0) }')-Esercenti"
APIM_V1_NAME="cgnonboardingportal-$ENV_SHORT-apim"
APIM_V1_RG="cgnonboardingportal-$ENV_SHORT-api-rg"
BACKUP_NAME="cgnonboardingportal-$ENV_SHORT-apim-v1-backup"
STORAGE_ACCOUNT_RG="cgnonboardingportal-$ENV_SHORT-terraform-rg"
STORAGE_ACCOUNT_NAME="cgnonboardingportal${ENV_SHORT}tf"
STORAGE_ACCOUNT_CONTAINER="tfstate"

key=$(az storage account keys list \
        -g $STORAGE_ACCOUNT_RG \
        -n $STORAGE_ACCOUNT_NAME \
        --query [0].value -o tsv)

az apim backup \
--name $APIM_V1_NAME \
-g $APIM_V1_RG \
--backup-name $BACKUP_NAME \
--storage-account-name $STORAGE_ACCOUNT_NAME \
--storage-account-container $STORAGE_ACCOUNT_CONTAINER \
--storage-account-key $key