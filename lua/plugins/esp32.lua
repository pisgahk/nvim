return {
    "Aietes/esp32.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        build_dir = "build.clang", -- must match your CMake build dir
    },
    config = function(_, opts)
        local ok, esp32 = pcall(require, "esp32")
        if ok and vim.fn.executable("idf.py") == 1 then
            esp32.setup(opts)
        end
    end,
}
