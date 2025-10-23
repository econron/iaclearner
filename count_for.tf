resource "terraform_data" "count_echo" {
  count = 3
  provisioner "local-exec" {
    command = "echo ${count.index} >> test.txt"
  }
}

# 結果は　0,1,2がtest.txtに並ぶ