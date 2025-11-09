module "ecs_cluster" {
    source = "../modules/ecs/cluster"
    service_name = "econron-iac-learning-for-ecs"
    env = terraform.workspace
    cluster_addtional_tags = {
        Usage = "econron-iac-learning-for-ecs cluster"
        ServiceName = "econron-iac-learning-for-ecs"
        Env = terraform.workspace
    }
}

output "ecs_cluster_name" {
    value = module.ecs_cluster.cluster_name
}

output "ecs_cluster_arn" {
    value = module.ecs_cluster.cluster_arn
}