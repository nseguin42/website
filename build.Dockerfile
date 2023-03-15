# Build the build environment for our application.
ARG ELIXIR_VERSION=1.14.3
ARG OTP_VERSION=25.3
ARG DEBIAN_VERSION=bullseye-20230227-slim

ARG BUILD_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG SHA

FROM ${BUILD_IMAGE} as builder

ENV SSL_KEY_PATH=/etc/certs/privkey.pem
ENV SSL_CERT_PATH=/etc/certs/fullchain.pem
ENV SSL_CA_CERT_PATH=/etc/certs/chain.pem

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git npm latexml \
    && apt-get clean

# prepare build dir
WORKDIR /app
RUN echo $(SHA) > /app/sha.txt


# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
COPY apps/ns/mix.exs ./apps/ns/mix.exs
COPY apps/ns_web/mix.exs ./apps/ns_web/mix.exs
RUN mix deps.get --only $MIX_ENV
