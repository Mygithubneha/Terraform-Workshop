resource "aws_s3_bucket" "storage" {
  bucket = "${var.bucket_name}"
  
  tags = {
    Name = "${var.bucket_name}"
}


}

resource "aws_s3_bucket_versioning" "storage" {
  bucket = aws_s3_bucket.storage.id
  versioning_configuration {
    status = "Enabled"
  }
}