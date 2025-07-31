s(
    "containerfile_template",
    fmt(
        [[
FROM {}

LABEL maintainer="{}"

RUN apt-get update && apt-get install -y \\
  {} \\
  && rm -rf /var/lib/apt/lists/*

RUN {} # Optional: install extra tools like markdown or rst support

COPY {} /usr/share/fonts/custom/
RUN fc-cache -fv

WORKDIR {}
CMD ["{}"]
]],
        {
            i(1, "ubuntu:22.04"),
            i(2, "your_name@example.com"),
            i(3, "neovim python3-pip fontconfig curl unzip git"),
            i(4, "pip3 install markdown docutils"),
            i(5, "fonts/*.ttf"),
            i(6, "/workspace"),
            i(7, "nvim"),
        }
    )
)
