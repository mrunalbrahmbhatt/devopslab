resource "azurerm_storage_account" "unecryptedstorage" {
  name                      = "unencryptedstoragedemo"
  resource_group_name       = data.azurerm_resource_group.contosostorage.name
  location                  = data.azurerm_resource_group.contosostorage.location
  account_tier              = "Hot"
  account_kind              = "StorageV2"
  access_tier               = "Hot"
  allow_blob_public_access  = true
  enable_https_traffic_only = true
  # Omit TLS version
}

# Fail: Creating a container with a public access level
resource "azurerm_storage_container" "public_container" {
  name                  = "public-container"
  storage_account_name  = azurerm_storage_account.unecryptedstorage.name
  # Using "container" grants public read access to the entire container
  container_access_type = "container"
}
