resource "aws_vpc" "vpc" {
  // cidrブロックの重複によるaws transit gatewayなどのサービスが使えなくなることを回避したいから抽象化
  cidr_block = var.vpc_cidr_block
  tags = {
    // コンソール画面で同じ名前がずらりと並ぶ状態を避けたいから抽象化
    Name = var.vpc_name
    // この辺りはdev,stg,prdと変えたいから抽象化
    Env = var.vpc_env
  }
}