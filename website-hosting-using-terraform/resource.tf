resource "aws_s3_bucket" "terra-bucket" {
  bucket = "temp-bucket32"

}

resource "aws_s3_bucket_public_access_block" "temp-bucket32" {
  bucket = aws_s3_bucket.terra-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.terra-bucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"


}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.terra-bucket.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"


}

resource "aws_s3_bucket_website_configuration" "terra-bucket" {
  bucket = aws_s3_bucket.terra-bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_policy" "policy_read_access" {
  bucket = aws_s3_bucket.terra-bucket.id
  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
	        "Principal": "*",
            "Action": [ "s3:GetObject" ],
            "Resource": [
              "${aws_s3_bucket.terra-bucket.arn}",
              "${aws_s3_bucket.terra-bucket.arn}/*"
      ]
    }
  ]
}
EOF
}