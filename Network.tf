resource "azurerm_virtual_network" "VNet01" {
  name                = var.VNETName
  location            = azurerm_resource_group.RSG.location
  resource_group_name = azurerm_resource_group.RSG.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["1.1.1.2", "8.8.8.8"]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "AVD-subnet1" {
  name                 = var.Subnet["sub1"]
  resource_group_name  = azurerm_resource_group.RSG.name
  virtual_network_name = azurerm_virtual_network.VNet01.name
  address_prefixes     = ["10.0.1.0/24"]
  }

resource "azurerm_subnet" "AVD-subnet2" {
  name                 = var.Subnet["sub2"]
  resource_group_name  = azurerm_resource_group.RSG.name
  virtual_network_name = azurerm_virtual_network.VNet01.name
  address_prefixes     = ["10.0.2.0/24"]
  }