FROM rust:buster as build-vpncloud
WORKDIR /build/
RUN apt update && apt install -y git libc6
RUN git clone https://github.com/dswd/vpncloud.git .
RUN cargo build --release

FROM debian:buster-slim
COPY --from=build-vpncloud /build/target/release/vpncloud /usr/local/bin/vpncloud

CMD ["/usr/local/bin/vpncloud","--help"]
