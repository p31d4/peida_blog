use axum::{
    http::{StatusCode, Uri},
    response::Html,
    Router,
    routing::get,
};

#[tokio::main]
async fn main() {
    let peida_blog = Router::new()
        .route(
            "/",
            get(|| async { Html("<h1>Hello Visitor!</h1><p><h2>This web page is under construction.</h2>") }))
        .fallback(fallback);

    // Start Server
    // ------------------------------------------------------------------------
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3104")
        .await
        .unwrap();
    axum::serve(listener, peida_blog.into_make_service())
        .await
        .unwrap();
    // ------------------------------------------------------------------------
}

async fn fallback(uri: Uri) -> (StatusCode, String) {
    (StatusCode::NOT_FOUND, format!("No route for {uri}"))
}
