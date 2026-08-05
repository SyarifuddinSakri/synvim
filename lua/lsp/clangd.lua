vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
    },

    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
    },

    filetypes = {
        "c",
        "cpp",
    },

    capabilities = {
        offsetEncoding = { "utf-8", "utf-16" },
    },
})

vim.lsp.enable("clangd")
