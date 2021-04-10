FROM golang:1.16.3-alpine

WORKDIR /go/src/app
COPY . .

ENV GO111MODULE=on
RUN apk update && apk add git
RUN go get github.com/pilu/fresh && go get github.com/gin-gonic/gin

CMD ["fresh"]