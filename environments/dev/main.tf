locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "dev"
  }
}


module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = "rsrg"
  rg_location = "NorthEurope"
  rg_tags     = local.common_tags
}

module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = "acrrs1"
  rg_name    = "rsrg"
  location   = "NorthEurope"
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-rs1"
  rg_name         = "rsrg"
  location        = "NorthEurope"
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-rs1"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

module "aks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = "aksrs11111"
  location   = "NorthEurope"
  rg_name    = "rsrg"
  dns_prefix = "aks-rs"
  tags       = local.common_tags
}


module "pip" {
   depends_on = [module.rg]
  source   = "../../modules/azurerm_public_ip"
  pip_name = "pip-rs1"
  rg_name  = "rsrg"
  location = "NorthEurope"
  sku      = "Standard"
  tags     = local.common_tags
}
