# count
locals {
  name = ["hanako", "jiro"]
}

resource "aws_cloudwatch_event_rule" "sample" {
  count               = length(local.name)
  name                = element(local.name, count.index)
  schedule_expression = "rate(5 minutes)"
}

# foreach
locals {
  name2 = ["taro", "hanako", "jiro"]
}

resource "aws_cloudwatch_event_rule" "sample2" {
  for_each            = toset(local.name2)
  name                = each.value
  schedule_expression = "rate(5 minutes)"
}

# foreach with map
locals {
  person = {
    taro   = { name = "taro", pref = "tokyo" }
    hanako = { name = "hanako", pref = "kanagawa" }
    jiro   = { name = "jiro", pref = "nagano" }
  }
}

resource "aws_cloudwatch_event_rule" "sample3" {
  for_each            = { for p in local.person : p.name => p }
  name                = "${each.value.name}-${each.value.pref}"
  schedule_expression = "rate(5 minutes)"
}