terraform {
    backend "s3" {
        bucket = "econron-iac-learning-for-vpc-default-sample-vpc-bucket"
        key    = "090_vpc/terraform.tfstate"
        region = "ap-northeast-1"
        dynamodb_table = "terraform_lock"
    }
}