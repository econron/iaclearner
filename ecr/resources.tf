module "ecr" {
    source = "../modules/ecs/ecr"
    service_name = "econron-iac-learning-for-ecr"
    env = terraform.workspace
    role = "ecr"
}