# 1. Create the S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-local-tofu-bucket"
}

# 2. Upload a file to the S3 Bucket
resource "aws_s3_object" "hello_world_file" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "hello.txt"
  source       = "${path.module}/hello.txt"
  content_type = "text/plain"
}