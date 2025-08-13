# STEP 1 build executable binary

FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:init-2.33.1

WORKDIR /fluent-bit

COPY ./bin/cloudwatch.so .
