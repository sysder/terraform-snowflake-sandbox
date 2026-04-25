output "database_name" {
  description = "作成されたデータベース名"
  value       = snowflake_database.this.name
}

output "schema_name" {
  description = "作成されたスキーマ名"
  value       = snowflake_schema.this.name
}
