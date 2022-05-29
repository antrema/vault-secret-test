FROM debian AS build-env

ADD antrema-cassl.crt /usr/local/share/ca-certificates/antrema-cassl.crt
ADD antrema-caroot.crt /usr/local/share/ca-certificates/antrema-caroot.crt

RUN apt-get update \
    && apt-get install -y ca-certificates \
    && update-ca-certificates

FROM gcr.io/distroless/base-debian10

COPY --from=build-env /etc/ssl/certs /etc/ssl/certs

WORKDIR /

COPY kubernetes_auth_verification /kubernetes_auth_verification

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/kubernetes_auth_verification"]
