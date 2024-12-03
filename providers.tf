terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.40.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.107.0"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.27.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~>3.4.2"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "~>0.9.6"
    }
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.99.0"
    }
  }

}


provider "snowflake" {
  #** Using default authentication with user is 'snowflake'
  # organization_name = "..." # required if not using profile. Can also be set via SNOWFLAKE_ORGANIZATION_NAME env var
  # account_name      = "..." # required if not using profile. Can also be set via SNOWFLAKE_ACCOUNT_NAME env var
  # user              = "..." # required if not using profile or token. Can also be set via SNOWFLAKE_USER env var
  # password          = "..."

  #** Using private key authentication
  # organization_name      = "..." # required if not using profile. Can also be set via SNOWFLAKE_ORGANIZATION_NAME env var
  # account_name           = "..." # required if not using profile. Can also be set via SNOWFLAKE_ACCOUNT_NAME env var
  # user                   = "..." # required if not using profile or token. Can also be set via SNOWFLAKE_USER env var
  # authenticator          = "SNOWFLAKE_JWT"
  # private_key            = "-----BEGIN ENCRYPTED PRIVATE KEY-----..."
  # private_key_passphrase = "passphrase"

  #** Using profile field, missing fields will be populated from ~/.snowflake/config TOML file
  # profile = "securityadmin"

  # // optional
  # role      = "..."
  # host      = "..."
  # warehouse = "..."
  # params = {
  #   query_tag = "..."
  # }
}

provider "azurerm" {
  # Configuration options
  /* Setup environment:
  1. Create new Service Principal
  SPN=$(az ad sp create-for-rbac --name "terraform-sp" --role="contributor" --scopes="/subscriptions/${ARM_SUBSCRIPTION_ID}" -o json)
    Example result: { "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "displayName": "terraform-sp", "password": "random_password_returned", "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" }
  2. Register terraform providers
  az provider list --query "[?registrationState=='NotRegistered']" -o table
  az provider register --namespace <providerNamespace>

  https://learn.microsoft.com/en-us/azure/key-vault/general/rbac-guide
  Alternatively can grant appID with owner permission
    az role assignment create --assignee ${ARM_CLIENT_ID} --role Owner --scope="/subscriptions/${ARM_SUBSCRIPTION_ID}"
    az role assignment create --assignee ${ARM_CLIENT_ID} --role "Key Vault Reader" --scope="/subscriptions/${ARM_SUBSCRIPTION_ID}"
    az role assignment create --assignee ${ARM_CLIENT_ID} --role "Key Vault Secrets User" --scope="/subscriptions/${ARM_SUBSCRIPTION_ID}"
  Checking permission
    az role assignment list --assignee=${ARM_CLIENT_ID}
  az login --service-principal --username ${ARM_CLIENT_ID} --password ${ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID}
  */
  features {}
  use_cli = true
  /*
  ARM_USE_MSI, ARM_CLIENT_ID, ARM_MSI_ENDPOINT
  export ARM_USE_MSI=true
  export ARM_SUBSCRIPTION_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  export ARM_TENANT_ID=72f988bf-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  export ARM_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx # only necessary for user assigned identity
  export ARM_MSI_ENDPOINT=$MSI_ENDPOINT # only necessary when the msi endpoint is different than the well-known one
  */

  # subscription_id = var.subscription_id # not required if already configure environment as above
  # client_id = var.appId
  # client_secret = var.spnPassword
  # tenant_id = var.tenant

}


