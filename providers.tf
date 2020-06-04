#Providers are listed here
terraform {
  required_version = "=0.12.26"
}

# Configure the Azure Provider
provider "azurerm" {
  version = "2.8.0"
  features {}
}

provider "random" {
  version = "2.2.1"
}

# Configure the Microsoft Azure Active Directory Provider
provider "azuread" {
  version = "=0.8.0"
}
