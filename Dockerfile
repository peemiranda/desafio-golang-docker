FROM golang:1.19 AS builder

WORKDIR /app

RUN go mod init example.com/app || true

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o app

FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]

