resource_group_name = "test-rg"
sa_config = [
  {
    name                     = "saexamplecopy1"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  },
  {
    name                     = "saexamplecopy2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
]
