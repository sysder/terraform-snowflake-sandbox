terraform {
  required_version = ">= 1.10"

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2"
    }
  }
}

resource "snowflake_database" "this" {
  name    = var.database_name
  comment = var.comment
}

resource "snowflake_schema" "this" {
  database = snowflake_database.this.name
  name     = var.schema_name
}

resource "snowflake_grant_privileges_to_account_role" "database_usage" {
  account_role_name = var.role_name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "schema_usage" {
  account_role_name = var.role_name
  privileges        = ["USAGE"]

  on_schema {
    schema_name = "${snowflake_database.this.name}.${snowflake_schema.this.name}"
  }
}
