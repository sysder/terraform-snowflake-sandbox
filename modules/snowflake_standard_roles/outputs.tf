output "read_only_role_name" {
  description = "READ_ONLYロール名"
  value       = snowflake_account_role.read_only.name
}

output "read_write_role_name" {
  description = "READ_WRITEロール名"
  value       = snowflake_account_role.read_write.name
}
