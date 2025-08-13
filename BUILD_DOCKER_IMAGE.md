# Build

```bash
make

docker build --no-cache -t udhos/aws-for-fluent-bit:init-2.33.1 .

docker push udhos/aws-for-fluent-bit:init-2.33.1
```

# References

```bash
docker run --rm -ti public.ecr.aws/aws-observability/aws-for-fluent-bit:init-2.33.1 sh

sh-4.2# find fluent-bit | grep cloud
fluent-bit/configs/plugin-and-storage-metrics-to-cloudwatch.conf
fluent-bit/configs/plugin-metrics-to-cloudwatch.conf
fluent-bit/licenses/cloudwatch
fluent-bit/licenses/cloudwatch/LICENSE
fluent-bit/licenses/cloudwatch/THIRD-PARTY
fluent-bit/cloudwatch.so
```

PR applied: https://github.com/aws/amazon-cloudwatch-logs-for-fluent-bit/pull/369
