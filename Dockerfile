FROM rust as builder
RUN cargo install vpncloud
RUN mkdir /out
RUN whereis vpncloud
RUN cp "$(whereis vpncloud | cut -d ' ' -f 2)" /out
RUN ls /out
FROM alpine
COPY --from=builder /out/vpncloud /usr/local/bin
RUN chmod 555 /usr/local/bin/vpncloud
RUN apk add --no-cache libgcc
CMD ["/usr/local/bin/vpncloud"]
#ENTRYPOINT ["vpncloud"]
