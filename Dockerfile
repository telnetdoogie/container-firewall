# Dockerfile for firewall container
FROM alpine:latest

RUN apk add --no-cache iptables iptables-legacy 

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

