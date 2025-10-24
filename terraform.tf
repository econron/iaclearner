terraform {
  backend "s3" {
    bucket = "econron-iaclearning-bucket"
    key    = "090_vpc/vpc.tfstate"
    region = "ap-northeast-1"
  }
}