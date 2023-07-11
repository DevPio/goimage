# url docker hub
# https://hub.docker.com/repository/docker/luccaspio/fullcycle/general

FROM golang:1.13-stretch AS BUILDER

WORKDIR /app

RUN echo 'package main; import "fmt"; func main() { fmt.Println("Full Cycle Rocks!!") }' | cat > fullcycle.go

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-s -w -extldflags "-static"' -o /app/fullcycle fullcycle.go


FROM scratch

WORKDIR /app

COPY --from=BUILDER  /app .


CMD  [ "/app/fullcycle" ]



