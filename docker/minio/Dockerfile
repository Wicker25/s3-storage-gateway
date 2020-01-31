FROM minio/minio

RUN apk add --no-cache bash curl

RUN curl -L 'https://github.com/vishnubob/wait-for-it/blob/master/wait-for-it.sh?raw=true' -o /bin/wait-for-it.sh
RUN chmod +x /bin/wait-for-it.sh

ENTRYPOINT minio gateway s3
