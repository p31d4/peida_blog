use dioxus::prelude::*;



fn main() {
    dioxus::launch(App);
}

#[component]
fn App() -> Element {
    rsx! {
        PeidaBlog {}
    }
}

#[component]
fn PeidaBlog() -> Element {
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
