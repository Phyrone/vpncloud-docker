FROM rust:buster as build-vpncloud
WORKDIR /build/
RUN apt update && apt install -y git libc6
RUN git clone https://github.com/dswd/vpncloud.git .
RUN cargo build --release

FROM debian:buster-slim
COPY --from=build-vpncloud /build/target/release/vpncloud /usr/local/bin/vpncloud
ENV VPNCLOUD_PORT=28111
ENV VPNCLOUD_PASSWORD=changeme
ENV VPNCLOUD_PEERS=""
CMD ["/usr/local/bin/vpncloud","--password","$VPNCLOUD_PASSWORD","--port","$VPNCLOUD_PORT","--peer","$VPNCLOUD_PEERS"]
