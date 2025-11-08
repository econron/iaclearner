# 今回モジュールを呼び出すファイル
module "vpc" {
  source         = "./modules/vpc"
  service_name   = "sample"
  env            = terraform.workspace
  vpc_cidr_block = "10.0.0.0/16"
  subnet_cidrs = {
    public  = ["10.0.1.0/24", "10.0.2.0/24"]
    private = ["10.0.3.0/24", "10.0.4.0/24"]
  }
  vpc_additional_tags = {
    Usage = "sample vpc explanation"
  }
}

module "ecs_cluster" {
  source                 = "./modules/ecs/cluster"
  service_name           = "sample"
  env                    = terraform.workspace
  cluster_addtional_tags = {}
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "ecs_cluster_arn" {
  value = module.ecs_cluster.cluster_arn
}