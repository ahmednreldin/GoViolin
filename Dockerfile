# syntax=docker/dockerfile:1
FROM golang:1.16-alpine AS builder

# Create a user so that the image doens't run as root
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "100001" \
    "appuser"

WORKDIR /app 

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./go-violin

FROM scratch AS Production

# Import the user and group files from the builder.
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

COPY --from=builder /app .

EXPOSE 8080

# Use the user that we've just created, one that isn't root
USER appuser:appuser

ENTRYPOINT [ "./go-violin" ]