FROM golang:1.19.1-buster as go-target
RUN apt-get update && apt-get install -y wget
ADD . /nmap-formatter
WORKDIR /nmap-formatter
RUN go build
RUN wget https://raw.githubusercontent.com/nmap/nmap/master/zenmap/radialnet/share/sample/nmap_example.xml

FROM golang:1.19.1-buster
COPY --from=go-target /nmap-formatter/nmap-formatter /
COPY --from=go-target /nmap-formatter/*.xml /testsuite/

ENTRYPOINT []
CMD ["/nmap-formatter", "csv", "@@"]
