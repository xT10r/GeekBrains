FROM golang:1.17-rc-buster as builder

# RUN mkdir /app
COPY . /app
WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM scratch

COPY --from=builder /app/main /

EXPOSE 8080
CMD ["/main"]
