use dioxus::prelude::*;

#[component]
pub fn PeidaBlog() -> Element {
    rsx! {
        h1 {
            "Hello Visitor!"
        },
        p {
            h2 {
                "This web page is under construction."
            }
        }
    }
}

#[component]
pub fn PeidaBlogDev() -> Element {
    rsx! {
        h1 { "Construction page" }
        p { "This is the development/construction route." }
    }
}
