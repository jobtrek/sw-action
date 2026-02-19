FROM rust:1.93.1-alpine3.23 AS build

# Install the dependencies
RUN apk add --no-cache build-base=~0.5 musl-dev=~1.2.5 git=~2.52.0

# When making a release, update the tag to match the wanted sw release : https://github.com/jobtrek/sw/releases
RUN git clone --depth 1 --branch v0.6.6 https://github.com/jobtrek/sw.git

WORKDIR /sw
RUN cargo build --release

# Final image
# checkov:skip=CKV_DOCKER_3:GitHub Actions require running as root
FROM alpine:3.23
HEALTHCHECK NONE
COPY --from=build /sw/target/release/sw /usr/local/bin/sw
RUN apk add --no-cache fd=~10.2.0

# Set the working directory inside the container.
WORKDIR /usr/src

# Copy any source file(s) required for the action.
COPY entrypoint.sh .

# Create a non-root user and switch to it
RUN addgroup -S actiongroup && adduser -S actionuser -G actiongroup && \
    chown -R actionuser:actiongroup /usr/src && \
    chmod +x /usr/src/entrypoint.sh

USER actionuser

# Configure the container to be run as an executable.
ENTRYPOINT ["/usr/src/entrypoint.sh"]
