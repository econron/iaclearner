terraform {
    backend "s3" {
        bucket = "econron-iac-learning-for-ecr-default-sample-ecr-bucket"
        key    = "090_ecr/terraform.tfstate"
        region = "ap-northeast-1"
        dynamodb_table = "terraform_lock"
    }
}