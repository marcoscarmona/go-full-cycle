
FROM golang:1.18 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w -s' -installsuffix cgo -o main .

FROM scratch 

WORKDIR /root/

COPY --from=builder /app/main /fullcycle

CMD ["/fullcycle"]
