FROM rust:1.79-alpine

# Install the dependencies
RUN apk add build-base
RUN apk add --no-cache musl-dev
RUN cargo install ast-grep --locked

# Get a specific version of the sw project
RUN git clone --depth 1 --branch v0.1.2 git@github.com:jobtrek/sw.git
WORKDIR /sw
RUN cargo build --release

# Final image
FROM alpine:3.20
COPY --from=0 /sw/target/release/sw /usr/local/bin/sw
COPY --from=0 /sw/sgconfig.yml /etc/jobtrek/sw/sgconfig.yml
COPY --from=0 /sw/ast-grep-rules /etc/jobtrek/sw/ast-grep-rules
COPY --from=0 /usr/local/cargo/bin/ast-grep /usr/local/bin/ast-grep
RUN apk add --no-cache fd
COPY test test

# Set the working directory inside the container.
WORKDIR /usr/src

# Copy any source file(s) required for the action.
COPY entrypoint.sh .

# Configure the container to be run as an executable.
ENTRYPOINT ["/usr/src/entrypoint.sh"]
