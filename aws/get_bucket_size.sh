#!/bin/bash

# Hints from
# [How can I get the size of an Amazon S3 bucket? - Server Fault](https://serverfault.com/questions/84815/how-can-i-get-the-size-of-an-amazon-s3-bucket)
# [amazon s3 - AWS S3: how do I see how much disk space is using - Stack Overflow](https://stackoverflow.com/questions/8975959/aws-s3-how-do-i-see-how-much-disk-space-is-using)

_bucket=$1

aws s3 ls s3://"${_bucket}" --recursive  | grep -v -E "(Bucket: |Prefix: |LastWriteTime|^$|--)" | awk 'BEGIN {total=0}{total+=$3}END{print total/1024/1024" MB"}'

# Another approach, gives total size (in Bytes, apparently) and number of objects
# aws s3api list-objects --bucket "${_bucket}" --output json --query "[sum(Contents[].Size), length(Contents[])]"

# Not so good:
# aws s3 ls s3://mybucket --recursive --human-readable --summarize
