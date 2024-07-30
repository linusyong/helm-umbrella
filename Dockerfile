FROM alpine:3.20.2

ARG VERSION=3.15.3

#   ARCH=linux-amd64|linux-arm64|darwin-amd64|darwin-arm64  ref: https://github.com/helm/helm/releases
ARG ARCH=linux-amd64

# ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${VERSION}-${ARCH}.tar.gz"
RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache curl ca-certificates git yamllint && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv ${ARCH}/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf ${ARCH} && \
    rm -f /var/cache/apk/* 

WORKDIR /apps

ENTRYPOINT ["helm"]
CMD ["--help"]
