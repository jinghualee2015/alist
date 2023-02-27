FROM alpine:edge as builder
LABEL stage=go-builder
WORKDIR /app/
COPY ./ ./
RUN apk add --no-cache bash curl gcc git go musl-dev; \
    bash build.sh release docker

FROM alpine:edge
LABEL MAINTAINER="i@nn.ci"
VOLUME /opt/alist/data/
WORKDIR /opt/alist/
COPY --from=builder /app/bin/alist ./
COPY entrypoint.sh /entrypoint.sh
COPY refresh_token.sh /refresh_token.sh
COPY data/data.db /opt/alist/data/
COPY data/token.txt /opt/alist/data/
RUN apk add --no-cache bash ca-certificates su-exec tzdata; \
    chmod +x /entrypoint.sh
ENV PUID=0 PGID=0 UMASK=022
EXPOSE 5244
ENTRYPOINT [ "/entrypoint.sh" ]
