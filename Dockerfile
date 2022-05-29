FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY kubernetes_auth_verification /kubernetes_auth_verification

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/kubernetes_auth_verification"]
