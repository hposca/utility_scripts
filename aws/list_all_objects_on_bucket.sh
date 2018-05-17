#!/bin/bash
#
# Based on [amazon web services - AWS S3 - How to get all files that are GLACIER storage class - Stack Overflow](https://stackoverflow.com/questions/42617247/aws-s3-how-to-get-all-files-that-are-glacier-storage-class)

_bucket=$1
_max_item=100000
_output_file="bucket_listing.txt"

iteration=0
_next_token=0
while true; do

    iteration=$((iteration+1))

    echo "Iteration #${iteration} - Next token: ${_next_token}"

    aws s3api list-objects \
    --output table \
    --bucket "${_bucket}" \
    --max-item "${_max_item}" \
    --starting-token "${_next_token}" >> "${_output_file}"

    _next_token=$(grep NextToken "${_output_file}" | awk '{print $2}' | sed 's/\("\|",\)//g')
    if [ ${#_next_token} -le 5 ]; then
        echo "No more files..."
        echo "Next token: $_next_token"
        break
        rm temp
    fi
    rm temp
done
echo "Exiting."
