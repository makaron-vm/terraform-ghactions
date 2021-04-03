#Create RG for storing State Files
az group create --location westeurope --name rg-terraformstate

#Create Storage Account
az storage account create --name $1 --resource-group rg-terraformstate --location westeurope --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group rg-terraformstate --account-name $1 --query '[0].value' -o tsv)

#Create Storage Container
az storage container create --name terraformdemo --account-name $1 --account-key $ACCOUNT_KEY

#Enable versioning on Storage Account1
az storage account blob-service-properties update --account-name $1 --enable-change-feed --enable-versioning true 

