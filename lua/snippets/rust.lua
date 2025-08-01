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
}
