s(
    "composeyaml_template",
    fmt(
        [[
version: '{}'
services:
  {}:
    image: {}:{}
    build:
      context: {}
      dockerfile: {}
    command: ["{}"]
    volumes:
      - {}:/root/.config/nvim:Z
      - {}:/usr/share/fonts/custom:Z
      - {}:/workspace:Z
    working_dir: {}
    environment:
      - TERM={}
]],
        {
            i(1, "3.8"),
            i(2, "neovim"),
            i(3, "neovim-container"),
            i(4, "latest"),
            i(5, "."),
            i(6, "Containerfile"),
            i(7, "nvim"),
            i(8, "~/.config/nvim"),
            i(9, "~/.local/share/fonts"),
            i(10, "~/projects"),
            i(11, "/workspace"),
            i(12, "xterm-256color"),
        }
    )
)
