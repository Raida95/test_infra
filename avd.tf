resource "azurerm_resource_group" "avd" {
  name     = "AVDResourceGroup"
  location = "francecentral"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "AVDVirtualNetwork"
  resource_group_name = azurerm_resource_group.avd.name
  location            = azurerm_resource_group.avd.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "AVDSubnet"
  resource_group_name  = azurerm_resource_group.avd.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  name                = "AVDHostPool"
  location            = azurerm_resource_group.avd.location
  resource_group_name = azurerm_resource_group.avd.name
  type                = "Pooled"
  load_balancer_type  = "BreadthFirst"
}

resource "azurerm_virtual_desktop_application_group" "appgroup" {
  name                = "AVDAppGroup"
  location            = azurerm_resource_group.avd.location
  resource_group_name = azurerm_resource_group.avd.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  type                = "Desktop"
  description         = "Desktop Application Group for AVD"
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "AVDWorkspace"
  location            = azurerm_resource_group.avd.location
  resource_group_name = azurerm_resource_group.avd.name
}

