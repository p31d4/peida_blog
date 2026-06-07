FROM p31d4/dx_devenv:0.1 AS chef
RUN cargo install cargo-chef --locked
WORKDIR /peida_blog

# -----------------------------------------------------------------------------
FROM chef AS planner
# Copy src code
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# -----------------------------------------------------------------------------
FROM chef AS builder
COPY --from=planner /peida_blog/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
# Build the application
RUN dx build --platform server --release

# -----------------------------------------------------------------------------
# Create a new image with a minimal image
FROM debian:bookworm-slim AS runtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libssl3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /peida_blog

COPY --from=builder /peida_blog/target/dx/peida_blog/release/web/server /peida_blog/server
COPY --from=builder /peida_blog/target/dx/peida_blog/release/web/public /peida_blog/public

ENV IP=0.0.0.0
ENV PORT=6666

ENTRYPOINT ["/peida_blog/server"]
