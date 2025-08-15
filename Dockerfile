FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:2.33.1 AS builder

RUN yum install -y tar make gcc
RUN curl https://raw.githubusercontent.com/udhos/update-golang/refs/heads/master/update-golang.sh > /tmp/update-golang.sh && \
    chmod +x /tmp/update-golang.sh && \
    /tmp/update-golang.sh 
ENV PATH="$PATH:/usr/local/go/bin"

WORKDIR /build

COPY . .
#COPY ./cloudwatch .
#COPY *.go .
#COPY go.* .
#COPY Makefile .
#RUN find -type f
#RUN go version
#RUN /usr/local/go/bin/go build -buildmode c-shared -o cloudwatch.so ./
RUN make

FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:2.33.1 AS final

# overwrite cloudwatch_logs plugin
COPY --from=builder /build/bin/cloudwatch.so /fluent-bit/cloudwatch.so

# overwrite fluent-bit binary (modified to support log group class)
RUN curl -L -o /fluent-bit/bin/fluent-bit.gz \
    https://github.com/udhos/upstream-to-fluent-bit/releases/download/1.9.10_log_group_class-3/fluent-bit.gz && \
    gunzip -f /fluent-bit/bin/fluent-bit.gz && \
    chmod +x /fluent-bit/bin/fluent-bit
