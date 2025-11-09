module "s3_for_iam" {
    source = "../modules/s3"
    service_name = "econron-iac-learning-for-iam"
    env = terraform.workspace
    bucket_name = "sample-iam-bucket"
}

output "s3_for_iam_bucket_name" {
    value = module.s3_for_iam.bucket_name
}

output "s3_for_iam_bucket_arn" {
    value = module.s3_for_iam.bucket_arn
}

output "s3_for_iam_bucket_id" {
    value = module.s3_for_iam.bucket_id
}

module "s3_for_ecs" {
    source = "../modules/s3"
    service_name = "econron-iac-learning-for-ecs"
    env = terraform.workspace
    bucket_name = "sample-ecs-bucket"
}

output "s3_for_ecs_bucket_name" {
    value = module.s3_for_ecs.bucket_name
}

output "s3_for_ecs_bucket_arn" {
    value = module.s3_for_ecs.bucket_arn
}

output "s3_for_ecs_bucket_id" {
    value = module.s3_for_ecs.bucket_id
}

module "s3_for_ecr" {
    source = "../modules/s3"
    service_name = "econron-iac-learning-for-ecr"
    env = terraform.workspace
    bucket_name = "sample-ecr-bucket"
}

output "s3_for_ecr_bucket_name" {
    value = module.s3_for_ecr.bucket_name
}

output "s3_for_ecr_bucket_arn" {
    value = module.s3_for_ecr.bucket_arn
}

output "s3_for_ecr_bucket_id" {
    value = module.s3_for_ecr.bucket_id
}