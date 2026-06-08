use axum::{response::Html, routing::get, Router};
use dioxus::prelude::*;

mod components;
use components::{PeidaBlog, PeidaBlogDev};

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(blog))
        .route("/construction", get(construction));

    let listener = tokio::net::TcpListener::bind("0.0.0.0:6666")
        .await
        .unwrap();

    axum::serve(listener, app).await.unwrap();
}

async fn blog() -> Html<String> {
    let body = render_component(PeidaBlog);
    Html(page("p31d4 Blog", body))
}

async fn construction() -> Html<String> {
    let body = render_component(PeidaBlogDev);
    Html(page("Construction", body))
}

fn render_component(component: fn() -> Element) -> String {
    let mut app = VirtualDom::new(component);
    app.rebuild_in_place();
    dioxus_ssr::render(&app)
}

fn page(title: &str, body: String) -> String {
    format!(
        r#"<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{}</title>
</head>
<body>
{}
</body>
</html>"#,
        title, body
    )
}
