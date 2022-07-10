resource "azurerm_resource_group" "RSG" {
  name     = var.RSG_Name
  location = var.location
}

resource "azurerm_virtual_desktop_host_pool" "AVD-01" {
  location            = azurerm_resource_group.RSG.location
  resource_group_name = azurerm_resource_group.RSG.name

  name                             = "${var.RSG_Name}-Pool1"
  friendly_name                    = "${var.RSG_Name}-Pool1"
  validate_environment             = false
  start_vm_on_connect              = true
  custom_rdp_properties            = "targetisaadjoined:i:1;audiomode:i:0;enablecredsspsupport:i:1;autoreconnection enabled:i:1;videoplaybackmode:i:1;camerastoredirect:s:;devicestoredirect:s:;drivestoredirect:s:;redirectclipboard:i:1;redirectcomports:i:0;redirectprinters:i:1;redirectsmartcards:i:0;usbdevicestoredirect:s:;use multimon:i:1;selectedmonitors:s:;smart sizing:i:1;dynamic resolution:i:1;"
  type                             = "Personal"
  load_balancer_type               = "Persistent"
  personal_desktop_assignment_type = "Automatic"
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "RegKey" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.AVD-01.id
  expiration_date = time_offset.time.rfc3339
}

resource "time_offset" "time" {
  offset_days = 1
}
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "${var.RSG_Name}-workspace"
  location            = azurerm_resource_group.RSG.location
  resource_group_name = azurerm_resource_group.RSG.name

  friendly_name = "${var.RSG_Name}-workspace"
}
resource "azurerm_virtual_desktop_application_group" "AppGroup-01" {
  name                = "${var.RSG_Name}-remoteapp"
  location            = azurerm_resource_group.RSG.location
  resource_group_name = azurerm_resource_group.RSG.name
  type                = "RemoteApp"
  host_pool_id        = azurerm_virtual_desktop_host_pool.AVD-01.id
}
resource "azurerm_virtual_desktop_workspace_application_group_association" "workspaceremoteapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.AppGroup-01.id
}