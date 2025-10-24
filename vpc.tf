resource "aws_vpc" "vpc" {
  // cidrブロックの重複によるaws transit gatewayなどのサービスが使えなくなることを回避したいから抽象化
  cidr_block = var.vpc_cidr_block
  // tagsが動的に追加できないため抽象化
  // ただし、このままだと必須タグとオプショナルタグを指定できない
  // → この課題に対して、additional_tagsのvarを定義し、merge関数を利用してmergeする
  tags = merge(
    var.vpc_additional_tags,
    {
      Name = var.vpc_name
      Env  = var.vpc_env
    }
  )
}