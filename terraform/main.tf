

resource "aws_instance" "example" {
  ami           = var.ami 
  instance_type = var.instance_type

  tags = {
    Name = "dev"
  }
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-terraform-2024"
  #acl    = "private"

  tags = {
    Name        = "ExampleBucket"
    Environment = "Dev"
  }
}

# Create 2 S3 buckets using count method
resource "aws_s3_bucket" "count_buckets" {
  count  = 2
  bucket = "my-terraform-bucket-${count.index + 1}-${formatdate("YYYYMMDD", timestamp())}"

  tags = {
    Name        = "Bucket-${count.index + 1}"
    Environment = "Dev"
    CreatedBy   = "Terraform"
    Index       = count.index
  }
}

# Optional: Add bucket versioning for the count-based buckets
# resource "aws_s3_bucket_versioning" "count_bucket_versioning" {
#   count  = 2
#   bucket = aws_s3_bucket.count_buckets[count.index].id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }
