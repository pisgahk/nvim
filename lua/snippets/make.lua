s(
    "makefile_template",
    fmt(
        [[
IMAGE={}
CONTEXT={}
TAG={}

build:
\tpodman build -t $(IMAGE):$(TAG) $(CONTEXT)

up:
\tpodman run -it --rm \\
\t  -v {}:/root/.config/nvim:Z \\
\t  -v {}:/usr/share/fonts/custom:Z \\
\t  -v {}:/workspace:Z \\
\t  --workdir /workspace $(IMAGE):$(TAG)

exec:
\tpodman exec -it $(IMAGE) nvim

clean:
\tpodman rmi $(IMAGE):$(TAG)
]],
        {
            i(1, "neovim-container"),
            i(2, "."),
            i(3, "latest"),
            i(4, "~/.config/nvim"),
            i(5, "~/.local/share/fonts"),
            i(6, "~/projects"),
        }
    )
)
