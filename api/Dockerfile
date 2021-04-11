FROM golang:1.16.3-alpine

WORKDIR /go/src/app
COPY . .

RUN apk update && apk --no-cache add git build-base

RUN go get github.com/pilu/fresh && \
  go get github.com/gin-gonic/gin && \
  go get github.com/rubenv/sql-migrate/... && \
  go get github.com/go-sql-driver/mysql && \
  go get github.com/jinzhu/gorm

CMD ["fresh"]