FROM rust:1.82.0-alpine3.20 AS build

# Install the dependencies
RUN apk add --no-cache build-base=~0.5 musl-dev=~1.2.5
RUN cargo install ast-grep --locked

# Get a specific version of the sw project
RUN apk add --no-cache git=2.45.2-r0
# When making a release, update the tag to match the wanted sw release : https://github.com/jobtrek/sw/releases
RUN git clone --depth 1 --branch v0.2.5 https://github.com/jobtrek/sw.git
WORKDIR /sw
RUN cargo build --release

# Final image
FROM alpine:3.20
COPY --from=build /sw/target/release/sw /usr/local/bin/sw
COPY --from=build /sw/sgconfig.yml /etc/jobtrek/sw/sgconfig.yml
COPY --from=build /sw/ast-grep-rules /etc/jobtrek/sw/ast-grep-rules
COPY --from=build /usr/local/cargo/bin/ast-grep /usr/local/bin/ast-grep
RUN apk add --no-cache fd=~10.0.0

# Set the working directory inside the container.
WORKDIR /github/workspace

# Copy any source file(s) required for the action.
COPY entrypoint.sh /entrypoint.sh

# Configure the container to be run as an executable.
ENTRYPOINT ["/entrypoint.sh"]

