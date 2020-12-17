FROM gcr.io/etcd-development/etcd:v3.4.14
LABEL org.opencontainers.image.source https://github.com/identw/etcd-k8s
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update \
    && apt-get install -y curl openssl \

    && mkdir -p /tmp/certs \
    && curl -L https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 -o /tmp/cfssl \
    && chmod +x /tmp/cfssl \
    && mv /tmp/cfssl /usr/local/bin/cfssl \
    && curl -L https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 -o /tmp/cfssljson \
    && chmod +x /tmp/cfssljson \
    && mv /tmp/cfssljson /usr/local/bin/cfssljson \

    && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \

    && apt-get purge -y curl \
    && apt-get --purge -y autoremove \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists
