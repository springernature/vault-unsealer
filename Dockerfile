FROM golang:1.9-alpine as builder
COPY . /go/src/github.com/jetstack/vault-unsealer
WORKDIR /go/src/github.com/jetstack/vault-unsealer
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
RUN go vet $(go list ./... | grep -v '/vendor/')
RUN go test $(go list ./... | grep -v '/vendor/')
RUN go build -a -tags netgo -o /vault-unsealer_linux_amd64

FROM alpine:3.6 AS resource
RUN apk add --update ca-certificates
COPY --from=builder /vault-unsealer_linux_amd64 /usr/local/bin/vault-unsealer
ENTRYPOINT ["/usr/local/bin/vault-unsealer"]

FROM resource
