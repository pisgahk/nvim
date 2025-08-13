local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
    s("comment", {
        t({ "<!-- " }),
        i(1, "Your comment here"),
        t({ " -->" }),
    }),

    s(
        "readme",
        fmt(
            [[
    # {}

    {}

    ## 🚀 Features
    - {}
    - {}
    - {}

    ## 📦 Installation
    ```bash
    {}
    ```

    ## 🛠️ Usage
    ```bash
    {}
    ```

    ## ⚙️ Configuration
    - {}
    - {}

    ## 🤝 Contributing
    Contributions are welcome! Please follow the [contributing guidelines](CONTRIBUTING.md) and submit a pull request.

    ## 📄 License
    This project is licensed under the {} License.

    ## 🙌 Acknowledgments
    - {}
    - {}

    ---
    > Built with ❤️ by {}
  ]],
            {
                i(1, "Project Title"),
                i(2, "A brief description of your project."),
                i(3, "Feature 1"),
                i(4, "Feature 2"),
                i(5, "Feature 3"),
                i(6, "Installation command or steps"),
                i(7, "Usage command or example"),
                i(8, "Config option 1"),
                i(9, "Config option 2"),
                i(10, "MIT"),
                i(11, "Tool or library used"),
                i(12, "Inspiration or contributor"),
                i(13, "Your Name or Handle"),
            }
        )
    ),
})
