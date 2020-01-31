#!/usr/bin/env bash
set -e

# Set up the client
mc config host add storage http://minio:9000 "${ROOT_ACCESS_KEY}" "${ROOT_SECRET_KEY}" --api S3v4

# Set up the policy
mc admin policy add storage provider-policy /configs/provider-policy.json

# Add the access keys and secrets
for i in {1..5}
do
    access_key_var="ACCESS_KEY_${i}"
    secret_key_var="SECRET_KEY_${i}"

    access_key="${!access_key_var}"
    secret_key="${!secret_key_var}"

    if [ -z "${access_key}" ]; then
        continue
    fi

    if [ -z "${secret_key}" ]; then
        echo "(!) ${secret_key_var} cannot be empty" >&2
        continue
    fi

    mc admin user add storage "${access_key}" "${secret_key}"
    mc admin policy set storage provider-policy user="${access_key}"
done
