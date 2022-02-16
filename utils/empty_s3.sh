#!/bin/bash

# Empty S3 buckets

. ../secret.env

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

aws s3 rm --recursive s3://${S3_BUCKET}/
aws s3 rm --recursive s3://${S3_BUCKET_FULLTEXT}/
