data "aws_availability_zones" "availability_zones" {
  state = "available"
  # すでにobsolete（廃止）になっているap-northeast-1bを除外
  exclude_names = [
    "ap-northeast-1b"
  ]
}

locals {
  number_of_availability_zones = length(data.aws_availability_zones.availability_zones.names)
}