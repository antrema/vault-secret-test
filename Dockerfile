FROM golang:1.16-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /kubernetes_auth_verification

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /kubernetes_auth_verification /kubernetes_auth_verification

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/kubernetes_auth_verification"]
