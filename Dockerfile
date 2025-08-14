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

COPY --from=builder /build/bin/cloudwatch.so /fluent-bit/cloudwatch.so
