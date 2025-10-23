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

