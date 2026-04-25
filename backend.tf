terraform {
  backend "s3" {
    bucket = "tf-snowflake-tfstate-530448593175-ap-northeast-1-an"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
