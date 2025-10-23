```sh
touch variables.tf
terraform init
```

```sh
touch provider.tf
terraform init
terraform fmt
terraform validate
terraform state list
terraform state show
```

リソースを再作成することなく付け替えたい

ex)

```tf
# 変更前
resource "aws_iam_role" "role" {

}

# 変更後
resource "aws_iam_role" "new_role" {

}
```

roleをnew_roleに付け替えたい

```sh
terraform state mv iam_role.aws_iam_role.role iam_role.aws_iam_role.new_role
```

mvコマンドみたいな感じ。

movedブロックでもOK。

```tf
moved {
  from = aws_iam_role.role
  to = aws_iam_role.new_role
}

resource "aws_iam_role" "new_role" {

}
```
こうすると、roleは消されずnew_roleに移行する。

## 6章繰り返し構文

リソース内部でcountを利用する方法について記載。

apply後のstate list

```sh
% terraform state list
aws_cloudwatch_event_rule.sample[0]
aws_cloudwatch_event_rule.sample[1]
aws_cloudwatch_event_rule.sample[2]
terraform_data.count_echo[0]
terraform_data.count_echo[1]
terraform_data.count_echo[2]
```

実際のtfはこう

```tf
locals {
  name = ["taro","hanako","jiro"]
}

resource "aws_cloudwatch_event_rule" "sample" {
  count = length(local.name)
  name = element(local.name, count.index)
  schedule_expression = "rate(5 minutes)"
}
```

ここでtaroを削除すると

1, taroはhanakoにreplace
2, hanakoはjiroにreplace
3, jiroはdelete

となる。

一方、同じものをfor_eachで書くと・・・

```tf
locals {
  name2 = ["taro", "hanako", "jiro"]
}

resource "aws_cloudwatch_event_rule" "sample2" {
  for_each            = toset(local.name2)
  name                = each.value
  schedule_expression = "rate(5 minutes)"
}
```

同様に3つ作成できる。

ここで先頭のtaroを削除してplan実行すると

```sh
Terraform will perform the following actions:

  # aws_cloudwatch_event_rule.sample2["taro"] will be destroyed
  # (because key ["taro"] is not in for_each map)
  - resource "aws_cloudwatch_event_rule" "sample2" {
      - arn                 = "arn:aws:events:ap-northeast-1:680100305263:rule/taro" -> null
      - event_bus_name      = "default" -> null
      - force_destroy       = false -> null
      - id                  = "taro" -> null
      - is_enabled          = true -> null
      - name                = "taro" -> null
      - schedule_expression = "rate(5 minutes)" -> null
      - state               = "ENABLED" -> null
      - tags_all            = {} -> null
        # (3 unchanged attributes hidden)
    }
```

のようにtaroだけdestroyする

for_eachに渡す際はtosetを利用すると良い。