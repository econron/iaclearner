resource "aws_s3_bucket" "bucket" {
    bucket = "${var.service_name}-${var.env}-${var.bucket_name}"
    tags = {
        Name = "${var.service_name}-${var.env}-${var.bucket_name}"
        Env = var.env
    }
}