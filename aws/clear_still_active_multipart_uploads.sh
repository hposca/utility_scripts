#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Will abort currently running/stuck multipart uploads. Use with caution.
# The ideal case is if you are not uploading files anymore and want to clear
# all the possible ones that are stuck into S3 staging area and, consequently
# are resulting in costs (regular S3 prices).

# This script was inspired by [Abort Multipart Uploads](https://docs.aws.amazon.com/AmazonS3/latest/dev/HLAbortMPUploadsJava.html)

# Improvement points:
# At the `list-multipart-uploads` call we are not dealing with pagination.

_bucket=$1
_tmp_file=$(mktemp)

echo "Listing multipart uploads..."
aws s3api list-multipart-uploads --bucket "${_bucket}" >> "${_tmp_file}"
echo ""

echo "Cleaning..."

jq -c '.Uploads[] | [.UploadId,.Key,.StorageClass]' "${_tmp_file}" | while read line; do

  _upload_id=$(echo "${line}" | jq '.[0]' | tr -d '"')
  _key=$(echo "${line}" | jq '.[1]' | tr -d '"')
  _storage_class=$(echo "${line}" | jq '.[2]' | tr -d '"')

  echo "Will abort key ${_key} , with upload_id of ${_upload_id} from bucket ${_bucket}..."
  aws s3api abort-multipart-upload \
    --bucket "${_bucket}" \
    --key "${_key}" \
    --upload-id "${_upload_id}"

  echo ""
  sleep 1
done
