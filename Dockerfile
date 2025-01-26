FROM golang:1.23.4-alpine3.21 AS builder

WORKDIR $GOPATH/src/app/

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o /main .

FROM scratch

COPY --from=builder /main .

CMD ["./main"]