resource "aws_s3_bucket" "newbucket" {
    bucket = "my-bucket"
  
}

resource "aws_s3_bucket_public_access_block" "newbucket" {
    bucket = aws_s3_bucket.newbucket.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
  
}

resource "aws_s3_object" "index" {
    bucket = "my-bucket"
    key = "index.html"
    source = "index.html"
    content_type = "text/html"

  
}

resource "aws_s3_object" "error" {
    bucket = "my-bucket"
    key = "error.html"
    source = "error.html"
    content_type = "text/html"

  
}

resource "aws_s3_bucket_website_configuration" "newbucket" {
    bucket = aws_s3_bucket.newbucket.id

    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "error.html"
    }
  
}

resource "aws_s3_buket_policy" "policy_read_access" {
    bucket = aws_s3_bucket.newbucket.id
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
	        "Principal": "*",
            "Action": [ "s3:GetObject" ],
            "Resource": [
              "${aws_s3_bucket.newbuket.arn}",
              "${aws_s3_bucket.newbuket.arn}/*"
      ]
    }
  ]
}
EOF
}