FROM ubuntu:latest

RUN apt update && apt install -y bind9 bind9utils bind9-doc dnsutils

EXPOSE 53/udp
EXPOSE 53/tcp

CMD ["/usr/sbin/named", "-g"]