FROM node:latest AS nodebuilder
WORKDIR /node
COPY . .
RUN npm i
RUN npx tailwindcss -i view/css/app.css -o public/styles.css
RUN npm run build

FROM golang:latest AS gobuilder
WORKDIR /app
COPY . .
RUN go mod download
RUN go install github.com/a-h/templ/cmd/templ@latest
RUN templ generate
RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root
COPY --from=gobuilder /app/server .
COPY --from=nodebuilder /node/public ./public
COPY /assets ./assets

EXPOSE 8080

CMD [ "./server" ]