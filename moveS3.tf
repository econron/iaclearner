locals {
  bucket_name = [
    "my",
    "your",
    "their"
  ]
}

resource "aws_s3_bucket" "sample_bucket" {
  count = length(local.bucket_name)
  bucket = "${count.index}-${local.bucket_name[count.index]}-econron-test-bucket"
}

## なんかうまく行かなかった
moved {
  from = aws_s3_bucket.sample_bucket[0]
  to = aws_s3_bucket.sample_bucket["0-my-econron-test-bucket"]
}