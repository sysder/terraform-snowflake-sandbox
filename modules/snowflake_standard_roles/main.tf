terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2"
    }
  }
}

locals {
  db_schema = "${var.database_name}.${var.schema_name}"
}

resource "snowflake_account_role" "read_only" {
  name    = "${var.database_name}_READ_ONLY"
  comment = "${var.database_name}の参照専用ロール"
}

resource "snowflake_account_role" "read_write" {
  name    = "${var.database_name}_READ_WRITE"
  comment = "${var.database_name}の読み書きロール"
}

# READ_ONLYへの権限付与
resource "snowflake_grant_privileges_to_account_role" "read_only_db" {
  account_role_name = snowflake_account_role.read_only.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = var.database_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "read_only_schema" {
  account_role_name = snowflake_account_role.read_only.name
  privileges        = ["USAGE"]

  on_schema {
    schema_name = local.db_schema
  }
}

resource "snowflake_grant_privileges_to_account_role" "read_only_tables" {
  account_role_name = snowflake_account_role.read_only.name
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = local.db_schema
    }
  }
}

# READ_WRITEへの権限付与
resource "snowflake_grant_privileges_to_account_role" "read_write_db" {
  account_role_name = snowflake_account_role.read_write.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = var.database_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "read_write_schema" {
  account_role_name = snowflake_account_role.read_write.name
  privileges        = ["USAGE", "CREATE TABLE"]

  on_schema {
    schema_name = local.db_schema
  }
}

resource "snowflake_grant_privileges_to_account_role" "read_write_tables" {
  account_role_name = snowflake_account_role.read_write.name
  privileges        = ["SELECT", "INSERT", "UPDATE", "DELETE"]

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = local.db_schema
    }
  }
}
