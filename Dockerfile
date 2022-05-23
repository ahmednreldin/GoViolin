# syntax=docker/dockerfile:1
FROM golang:1.16-alpine AS builder

WORKDIR /app 

COPY ./go.mod ./go.sum ./
COPY . ./

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./...

FROM scratch AS Production

COPY --from=builder /app .

EXPOSE 8080

ENTRYPOINT [ "./main" ]
