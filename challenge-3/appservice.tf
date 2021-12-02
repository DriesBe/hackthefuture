## With terraform you use a 'resource' block to define the resource that must be created on Azure.
## The resource block takes a resource type and a name.
## Then you need to specify all parameters that are required for the resource.
## For a resource group on Azure you need to specify the location and the name.
resource "azurerm_resource_group" "group" {
  location = "westeurope"
  name     = "rg-challenge-3"
}

## Jill, complete the blocks below which will create an App Service Plan and the App Service


locals {
  team_id = 29795
}

## An App Service Plan mainly defines the hardware that is used to host your App Service.
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "${azurerm_resource_group.group.name}-plan"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  kind                = "Linux"
  reserved = true # Leave this as it is mandatory for Linux plans

  # Define Linux as Host OS

  # Choose Standard Tier, Size = S1
  sku {
    tier = "Standard"
    size = "S1"
  }
  
}

## Azure App Service enables you to build and host web apps, mobile back ends, and RESTful APIs in the programming language of your choice without managing infrastructure. 
## It also allows to use Docker containers to run your applications.
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
## Use the documentation to deploy the docker image: mvandep3/htf:latest
resource "azurerm_app_service" "app" {
  name                = "${azurerm_resource_group.group.name}-app-${local.team_id}"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  ## Uncomment The Line below !!!!! Link me with the plan by using the id of the item created above
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  # Configure Docker Image mvandep3/htf:latest here
  site_config {
    linux_fx_version = "DOCKER|mvandep3/htf:latest"
  }

  # Configure your team ID above
  app_settings = {
    "TEAM_ID" = local.team_id
  }
}
