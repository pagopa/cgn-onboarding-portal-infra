#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Illegal number of parameters"
  echo "Usage: ${0} <project> <env>"
  exit 0
fi

project=$1
env=$2

RESOURCE_GROUP_NAME=${project}-${env}-terraform-rg
STORAGE_ACCOUNT_NAME=${project}${env}tf
CONTAINER_NAME=tfstate
LOCATION="WestEurope"

# Create resource group
az group create --name ${RESOURCE_GROUP_NAME} --location ${LOCATION}

# Create storage account
az storage account create --resource-group ${RESOURCE_GROUP_NAME} \
--name ${STORAGE_ACCOUNT_NAME} \
--sku Standard_LRS \
--allow-blob-public-access false \
--encryption-services blob

# Create blob container
az storage container create --name ${CONTAINER_NAME} \
--account-name ${STORAGE_ACCOUNT_NAME}

echo "Resource group: ${RESOURCE_GROUP_NAME}"
echo "Storage Account Name: ${STORAGE_ACCOUNT_NAME}"
echo "Container Name: ${CONTAINER_NAME}"