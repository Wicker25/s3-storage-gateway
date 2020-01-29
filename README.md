# \[POC\] S3 Origin Shield


## Introduction

TODO

## Getting started

```
$ docker-compose build

$ AWS_ACCESS_KEY_ID='xxxxxx' \
AWS_SECRET_ACCESS_KEY='xxxxxx' \
AWS_ENDPOINT_URL='s3.us-east-2.amazonaws.com' \
docker-compose up
```


## Set up the MinIO Client

```
$ mc config host add storage http://127.0.0.1:9080 sg_access_key sg_secret_key --api S3v4
```

## Create the IAM policy

```
$ cat > provider-policy.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::asset-bucket",
        "arn:aws:s3:::asset-bucket/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
```

```
$ mc admin policy add storage provider-policy provider-policy.json
```

## Create the AWS Access Key and Secret

To create the AWS Access Key and Secret:

```
$ mc admin user add storage <ACCESS_KEY> <SECRET_KEY>
```

Then, apply the policy to them:

```
$ mc admin policy set storage provider-policy user=<ACCESS_KEY>
```

## Test the Origin Shield with `aws-cli`

Start configuring your client with the Origin's credentials:

```
$ aws configure
AWS Access Key ID [None]: <ACCESS_KEY>
AWS Secret Access Key [None]: <SECRET_KEY>
# ...
```

To download a file from S3:

```
$ aws --endpoint-url http://127.0.0.1:9000 s3 cp s3://asset-bucket/test.mp4 .
```
