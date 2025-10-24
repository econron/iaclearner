terraform {
  backend "s3" {
    bucket = "econron-iaclearning-bucket"
    key    = "090_vpc/vpc.tfstate"
    region = "ap-northeast-1"
    // 複数人が同時にapplyした際にstateの一貫性が保証されないのでlockする
    # lock_file = true
    // DynamoDBでロックする
    dynamodb_table = "terraform_lock"
  }
}