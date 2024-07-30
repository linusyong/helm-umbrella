FROM alpine:3.14

ARG VERSION=3.11.3

# ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${VERSION}-linux-amd64.tar.gz"
RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache curl ca-certificates git yamllint && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    rm -f /var/cache/apk/* 

WORKDIR /apps

ENTRYPOINT ["helm"]
CMD ["--help"]
