FROM golang:1.24 AS build

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN go build -o main .

# stage 2
FROM gcr.io/distroless/base

COPY --from=build /app/main /main
COPY --from=build /app/static /static

EXPOSE 8081

CMD ["/main"]
