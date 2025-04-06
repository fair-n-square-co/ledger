FROM golang:1.23 as build
WORKDIR /app
COPY . .
ENV GOOS linux
ENV CGO_ENABLED 0
RUN go build -v -o app ./cmd/ledger

# Copy the binary to distroless image
FROM gcr.io/distroless/base as prod
COPY --from=build /app .

EXPOSE 8080
EXPOSE 8081
CMD ["./app"]
