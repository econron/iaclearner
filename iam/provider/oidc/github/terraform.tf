terraform {
    backend "s3" {
        bucket = "econron-iac-learning-for-iam-default-sample-iam-bucket"
        key    = "090_iam/terraform.tfstate"
        region = "ap-northeast-1"
        dynamodb_table = "terraform_lock"
    }
}