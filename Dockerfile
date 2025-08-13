# STEP 1 build executable binary

FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:2.33.1

WORKDIR /fluent-bit

COPY ./bin/cloudwatch.so .
