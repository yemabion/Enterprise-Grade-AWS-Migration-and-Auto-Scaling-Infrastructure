resource "aws_s3_bucket" "migration" {
  bucket        = "${var.project_name}-migration-2026"
  force_destroy = false

  tags = {
    Name = "${var.project_name}-migration"
  }
}

resource "aws_s3_bucket_ownership_controls" "migration" {
  bucket = aws_s3_bucket.migration.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "migration" {
  bucket = aws_s3_bucket.migration.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "migration" {
  bucket = aws_s3_bucket.migration.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "migration" {
  bucket = aws_s3_bucket.migration.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }

    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_policy" "migration" {
  bucket = aws_s3_bucket.migration.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "DenyInsecureTransport"
        Effect = "Deny"

        Principal = "*"

        Action = "s3:*"

        Resource = [
          aws_s3_bucket.migration.arn,
          "${aws_s3_bucket.migration.arn}/*"
        ]

        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

output "migration_bucket_name" {
  value = aws_s3_bucket.migration.bucket
}