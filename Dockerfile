FROM golang:1.10.0
RUN go get github.com/codegangsta/negroni
RUN go get github.com/gorilla/mux
RUN go get github.com/xyproto/simpleredis
WORKDIR /app
ADD ./main.go .
RUN CGO_ENABLED=0 GOOD=linux go build -o main .


FROM scratch
WORKDIR /app
COPY --from=0 /app/main .
COPY ./public/index.html public/index.html
COPY ./public/script.js public/script.js
COPY ./public/style.css public/style.css
CMD ["/app/main"]
EXPOSE 3000

