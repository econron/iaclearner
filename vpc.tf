resource "aws_vpc" "vpc" {
  // cidrブロックの重複によるaws transit gatewayなどのサービスが使えなくなることを回避したいから抽象化
  cidr_block = var.vpc_cidr_block
  // tagsが動的に追加できないため抽象化
  // ただし、このままだと必須タグとオプショナルタグを指定できない
  tags = var.vpc_tags
}