FROM ghcr.io/linkwarden/linkwarden:latest AS builder

FROM cgr.dev/chainguard/wolfi-base:latest
WORKDIR /data


COPY --from=builder /usr/local/bin/monolith /usr/local/bin/monolith
COPY --from=builder /data /data

RUN apk add curl ca-certificates yarn nodejs-22

RUN yarn prisma:generate && \
    yarn web:build

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
            CMD [ "/usr/bin/curl", "--silent", "--fail", "http://127.0.0.1:3000/" ]

EXPOSE 3000

CMD ["sh", "-c", "yarn prisma:deploy && yarn concurrently:start"]
