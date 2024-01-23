
resource "aws_s3_bucket" "mybucket" {
  bucket              = "sometest037540"
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags = {
    app = "mybabby"
    cc  = "hello"
  }
  tags_all = {
    app = "mybabby"
    cc  = "hello"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse-mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "arn:aws:kms:us-east-1:001317387464:key/88a6478c-40f5-48b9-b9bb-f6e5f70a8da0"
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}


resource "aws_s3_bucket" "example" {
  bucket = "craig-tf-test-bucket"

  tags = {
    Name        = "craig_bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  depends_on = [aws_s3_bucket_versioning.example]
  bucket     = aws_s3_bucket.example.id

  rule {
    id = "rule-1"
    noncurrent_version_expiration {
      noncurrent_days = 1
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}
