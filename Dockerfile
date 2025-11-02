FROM public.ecr.aws/spacelift/runner-terraform:latest

LABEL org.opencontainers.image.title="processpipe-spacelift-runner" \
      org.opencontainers.image.description="ProcessPipe customized Spacelift runner image with OpenSSL installed." \
      org.opencontainers.image.url="https://github.com/ProcessPipe/processpipe-spacelift-runner" \
      org.opencontainers.image.source="https://github.com/ProcessPipe/processpipe-spacelift-runner" \
      org.opencontainers.image.vendor="ProcessPipe" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.documentation="https://github.com/ProcessPipe/processpipe-spacelift-runner/blob/main/README.md"

USER root

RUN apk add --no-cache openssl && rm -rf /var/cache/apk/*

USER spacelift
