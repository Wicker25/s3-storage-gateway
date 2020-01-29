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

## Testing the Origin Shield with `aws-cli`

Start configuring your client with the Storage Gateway's credentials:

```
$ aws configure
AWS Access Key ID [None]: sg_access_key
AWS Secret Access Key [None]: sg_secret_key
# ...
```

To download a file from S3:

```
$ aws --endpoint-url http://127.0.0.1:9000 s3 cp s3://bucket/test.mp4 .
```
