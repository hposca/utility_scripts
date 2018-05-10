#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

openssl pkcs8 -in $1 -nocrypt -topk8 -outform DER | openssl sha1 -c
