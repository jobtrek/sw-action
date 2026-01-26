FROM rust:1.93.0-alpine3.23 AS build

# Install the dependencies
RUN apk add --no-cache build-base=~0.5 musl-dev=~1.2.5

# Get a specific version of the sw project
RUN apk add --no-cache git=~2.52.0
# When making a release, update the tag to match the wanted sw release : https://github.com/jobtrek/sw/releases
RUN git clone --depth 1 --branch v0.5.4 https://github.com/jobtrek/sw.git
WORKDIR /sw
RUN cargo build --release

# Final image
# checkov:skip=CKV_DOCKER_3:GitHub Actions require running as root
FROM alpine:3.23
HEALTHCHECK NONE
COPY --from=build /sw/target/release/sw /usr/local/bin/sw
RUN apk add --no-cache fd=~10.2.0

# Set the working directory inside the container.
WORKDIR /github/workspace

# Copy any source file(s) required for the action.
COPY entrypoint.sh /entrypoint.sh

# Configure the container to be run as an executable.
ENTRYPOINT ["/entrypoint.sh"]
