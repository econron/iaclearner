terraform {
    backend "s3" {
        bucket = "econron-iac-learning-for-ecs-default-sample-ecs-bucket"
        key    = "090_ecs/terraform.tfstate"
        region = "ap-northeast-1"
        dynamodb_table = "terraform_lock"
    }
}