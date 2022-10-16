<div align="center">

# **D**ocker **V**olume **B**ackup to **S3**

[![CICD](https://github.com/The-Noah/dvbs3/actions/workflows/cicd.yml/badge.svg)](https://github.com/The-Noah/dvbs3/actions/workflows/cicd.yml)

</div>

```bash
docker pull ghcr.io/the-noah/dvbs3:latest
```

## Usage

```bash
docker run -d --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --env-file /path/to/.env \
  ghcr.io/the-noah/dvbs3:latest \
  volume_to_backup
```

## Environment Variables

| Variable | Description | Example |
| --- | --- | --- |
| `AWS_ACCESS_KEY_ID` | AWS Access Key ID | |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Access Key | |
| `S3_HOST` | S3 Host | `s3.amazonaws.com` |
| `S3_HOST_BUCKET` | S3 Host Bucket Template | `%(bucket)s.s3.amazonaws.com` |
| `S3_BUCKET` | S3 Bucket | `docker-volume-backups` |

## Early Development

This project is in early development. It is somewhat messy to use, but it works. I will be cleaning it up and adding more features in the future.

## License

[MIT](LICENSE)
