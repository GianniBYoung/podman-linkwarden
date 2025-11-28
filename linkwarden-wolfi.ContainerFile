FROM ghcr.io/linkwarden/linkwarden:latest AS builder

FROM cgr.dev/chainguard/wolfi-base:latest
#FROM cgr.dev/chainguard/node:latest-dev
WORKDIR /data


COPY --from=builder /usr/local/bin/monolith /usr/local/bin/monolith
COPY --from=builder /data /data

#USER root
RUN apk add curl ca-certificates yarn nodejs-22
#RUN apk add curl ca-certificates

#RUN chown -R node: /data
#USER node
RUN yarn prisma:generate && \
    yarn web:build

EXPOSE 3000

CMD ["sh", "-c", "yarn prisma:deploy && yarn concurrently:start"]
#CMD ["/usr/bin/yarn prisma:deploy && /usr/bin/yarn concurrently:start"]
