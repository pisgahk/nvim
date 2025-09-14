local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("test", {
        t({ "#[cfg(test)]", "mod tests {", "    use super::*;", "" }),
        t({ "    #[test]", "    fn " }),
        i(1, "test_name"),
        t({ "() {", "        " }),
        i(2, "// test logic here"),
        t({ "", "    }", "}" }),
    }),

    s("drv", {
        t("#[derive("),
        i(1, "Debug, Clone"),
        t(")]"),
    }),

    s("rocket(template)", {
        t({
            "#[macro_use] extern crate rocket;",
            "",
            '#[get("/")]',
            "fn index() -> &'static str {",
            '    "Hello, world!"',
            "}",
            "",
            "#[launch]",
            "fn rocket() -> _ {",
            '    rocket::build().mount("/", routes![index])',
            "}",
        }),
    }),

    s(
        "actix-hello_world(template)",
        fmt(
            [[
use actix_web::{{web, App, HttpResponse, HttpServer, Responder, Result}};

async fn {}() -> impl Responder {{
    HttpResponse::Ok().body("{}")
}}

#[actix_web::main]
async fn main() -> Result<()> {{
    println!("Listening on port {}");

    HttpServer::new(|| {{
        App::new().route("{}", web::get().to({}))
    }})
    .bind("127.0.0.1:{}")?
    .run()
    .await;

    Ok(())
}}

// Run with `http://127.0.0.1:{}/hello` in browser.

// Probable file-tree
/*


.
+-- Cargo.lock
+-- Cargo.toml
+-- src
|   +-- main.rs
+-- static
    +-- css
    |   +-- index.css
    +-- image
    |   +-- image1.jpg
    |   +-- image2.jpg
    |   +-- image3.jpg
    +-- index.html
*/

]],
            {
                i(1, "hello"),       -- function name
                i(2, "Hello World"), -- response body
                i(3, "8080"),        -- port for println
                i(4, "/hello"),      -- route path
                rep(1),              -- function name again
                rep(3),              -- port for bind
                rep(3),              -- port for comment
            }
        )
    ),

    s(
        "actix-connecting_web(template)",
        fmt(
            [[
use actix_files::NamedFile;
use actix_web::{{web, App, HttpServer, Result}};

async fn {}() -> Result<NamedFile> {{
    Ok(NamedFile::open("{}")?)
}}

#[actix_web::main]
async fn main() -> Result<()> {{
    println!("Listening on port {}");

    HttpServer::new(|| {{
        App::new().route("{}", web::get().to({}))
    }})
    .bind("127.0.0.1:{}")?
    .run()
    .await;

    Ok(())
}}

// Run with `http://127.0.0.1:{}/` in browser.

// Probable file-tree
/*


.
+-- Cargo.lock
+-- Cargo.toml
+-- src
|   +-- main.rs
+-- static
    +-- css
    |   +-- index.css
    +-- image
    |   +-- image1.jpg
    |   +-- image2.jpg
    |   +-- image3.jpg
    +-- index.html
*/

]],
            {
                i(1, "index"),               -- function name
                i(2, "./static/index.html"), -- file path
                i(3, "8080"),                -- port
                i(4, "/"),                   -- route path
                rep(1),                      -- function name again
                rep(3),                      -- port for bind
                rep(3),                      -- port for comment
            }
        )
    ),

    s(
        "deref-method(template)",
        fmt(
            [[
    impl std::ops::Deref for {} {{
        type Target = {};
        fn deref(&self) -> &Self::Target {{
            &self.0
        }}
    }}
  ]],
            {
                i(1, "Wrapper"), -- Struct name
                i(2, "T"),       -- Target type
            }
        )
    ),
}
