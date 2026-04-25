variable "database_name" {
  description = "データベース名"
  type        = string
}

variable "schema_name" {
  description = "スキーマ名"
  type        = string
  default     = "PUBLIC"
}

variable "role_name" {
  description = "権限を付与するロール名"
  type        = string
}

variable "comment" {
  description = "データベースのコメント"
  type        = string
  default     = ""
}
