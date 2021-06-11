FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.52.1

RUN apt-get update && apt-get install -y build-essential protobuf-compiler autoconf automake libtool make g++ unzip clang pkg-config gcc-multilib curl wget git ca-certificates libssl-dev openssl

RUN set -eux; \
    rustArch="x86_64-unknown-linux-gnu"; \
    wget "https://static.rust-lang.org/rustup/archive/1.24.1/${rustArch}/rustup-init"; \
    echo "fb3a7425e3f10d51f0480ac3cdb3e725977955b2ba21c9bdac35309563b115e8 *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; 

RUN rustup component add rustfmt