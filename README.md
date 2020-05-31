# \[POC\] S3 Storage Gateway


## Introduction

![storage gateway diagram](https://github.com/Wicker25/s3-storage-gateway/raw/master/docs/storage-gateway.png)

## Getting started

Create the IAM policy for the CDN providers:

```
$ cat > configs/provider-policy.json << EOF
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

Then you can start up the containers:

```
$ AWS_ACCESS_KEY_ID='xxxxxx' \
AWS_SECRET_ACCESS_KEY='xxxxxx' \
AWS_ENDPOINT_URL='s3.us-east-2.amazonaws.com' \
ROOT_ACCESS_KEY='xxxxxx' \
ROOT_SECRET_KEY='xxxxxx' \
ACCESS_KEY_1='xxxxxx' \
SECRET_KEY_1='xxxxxx' \
ACCESS_KEY_2='xxxxxx' \
SECRET_KEY_2='xxxxxx' \
docker-compose up
```

## Set up the MinIO Client

```
$ mc config host add storage http://127.0.0.1:9080 <ROOT_ACCESS_KEY> <ROOT_SECRET_KEY> --api S3v4
```

## Test the Storage Gateway with `aws-cli`

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
