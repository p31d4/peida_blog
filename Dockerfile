FROM messense/rust-musl-cross:x86_64-musl AS chef
RUN cargo install cargo-chef --locked
WORKDIR /peida_blog

FROM chef AS planner
# Copy src code
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM chef AS builder
COPY --from=planner /peida_blog/recipe.json recipe.json
RUN cargo chef cook --release --target x86_64-unknown-linux-musl --recipe-path recipe.json
COPY . .
# Build the application
RUN cargo build --release --target x86_64-unknown-linux-musl

# -----------------------------------------------------------------------------
# Create a new image with a minimal image
FROM scratch
COPY --from=builder /peida_blog/target/x86_64-unknown-linux-musl/release/peida_blog /peida_blog
ENTRYPOINT ["/peida_blog"]
EXPOSE 3104
