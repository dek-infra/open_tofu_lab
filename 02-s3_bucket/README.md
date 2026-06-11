# Lab 2: S3 Buckets and Object Storage

In this lab, we provision an S3 Bucket locally and automatically upload a file into it during the `apply` process.

## 🚀 How to Run the Lab

### 1. Start LocalStack for S3
```bash
cd /root/_workspace/open_tofu_lab/02-s3_bucket
docker compose -f docker-compose.dev.yaml up -d
```

### 2. Deploy Infrastructure
```bash
tofu init
tofu apply -auto-approve
```

### 3. Verify the S3 File Using AWS CLI
List the bucket contents:
```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://my-local-tofu-bucket
```
Read the file back to your console:
```bash
aws --endpoint-url=http://localhost:4566 s3 cp s3://my-local-tofu-bucket/hello.txt -
```