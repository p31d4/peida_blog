FROM messense/rust-musl-cross:x86_64-musl as builder

WORKDIR /peida_blog

# Copy src code
COPY . .

# Build the application
RUN cargo build --release --target x86_64-unknown-linux-musl

# -----------------------------------------------------------------------------
# Create a new image with a minimal image
FROM scratch

COPY --from=builder /peida_blog/target/x86_64-unknown-linux-musl/release/peida_blog /peida_blog
ENTRYPOINT ["/peida_blog"]
EXPOSE 3104
