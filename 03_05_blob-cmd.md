# create a resource group for the state storage
az group create --location eastus --resource-group terraform-state-rg

# create a storage account with a unique storage name 
az storage account create --name <YOUR_UNIQUE_STORAGE_ACCOUNT_NAME> --resource-group terraform-state-rg --sku Standard_LRS --encryption-services blob --location eastus

# create a container for the state file. use a unique account name
az storage container create --name tfstate --account-name <YOUR_UNIQUE_STORAGE_ACCOUNT_NAME>

# enable versioning for state file history.
az storage account blob-service-properties update --resource-group terraform-state-rg --account-name <YOUR_UNIQUE_STORAGE_ACCOUNT_NAME> --enable-versioning true

# enable blob soft delete & container soft delete
az storage account blob-service-properties update --resource-group terraform-state-rg --account-name <YOUR_UNIQUE_STORAGE_ACCOUNT_NAME> --enable-delete-retention true --delete-retention-days 14 --enable-container-delete-retention true --container-delete-retention-days 9

