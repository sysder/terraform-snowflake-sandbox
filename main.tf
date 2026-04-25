terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2"
    }
  }
}

provider "snowflake" {
  organization_name = "ZOXITAX"
  account_name      = "vz14856"
  user              = "TF_USER"
  authenticator     = "SNOWFLAKE_JWT"
  private_key       = file("${path.module}/keys/tf_user_rsa_key.p8")
  role              = "TF_ROLE"
}

resource "snowflake_account_role" "sandbox_role" {
  name    = "SANDBOX_ROLE"
  comment = "Sandbox role managed by Terraform"
}

resource "snowflake_warehouse" "sandbox_wh" {
  name           = "SANDBOX_WH"
  warehouse_size = "XSMALL"
  auto_suspend   = 60
  auto_resume    = true
  comment        = "Sandbox warehouse managed by Terraform"
}

module "sandbox_db" {
  source = "./modules/snowflake_database"

  database_name = "SANDBOX_DB"
  schema_name   = "SANDBOX_SCHEMA"
  role_name     = snowflake_account_role.sandbox_role.name
  comment       = "Sandbox database managed by Terraform"
}
