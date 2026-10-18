provider "aws" {
    region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "backon-learn-terraform-state"

    # prevent accidental deletion of this s3 bucket
    lifecycle {
        prevent_destroy = true
    }
}

# Enable versioning to see the full revision history of the state file
resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
        status = "Enabled"
    }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
    bucket = aws_s3_bucket.terraform_state.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Explicitly block all public access to the s3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.terraform_state.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

terraform {
    backend "s3" {
        bucket = "backon-learn-terraform-state"
        key = "global/s3/terraform.tfstate"
        region = "us-east-2"

        use_lockfile = true
        encrypt = true
    }
}

# output "s3_bucket_arn" {
#     value = aws_s3_bucket.terraform_state.arn
#     description = "The ARN of the S3 bucket"
# }