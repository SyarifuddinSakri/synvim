require("gitsigns").setup({
    current_line_blame = true,
})

vim.keymap.set("n", "<leader>gb", function()
    require("gitsigns").blame_line({ full = true })
end, {
    desc = "[G]it [B]lame line",
})

vim.keymap.set("n", "<leader>gc", function()
    local line = vim.fn.line(".")
    local file = vim.fn.expand("%:p")

    local sha = vim.fn.system({
        "git",
        "-C", vim.fn.fnamemodify(file, ":h"),
        "blame",
        "-L", line .. "," .. line,
        "--porcelain",
        vim.fn.fnamemodify(file, ":t"),
    }):match("^([0-9a-f]+)")

    if sha then
        vim.fn.setreg("+", sha)
        print("Copied: " .. sha)
    else
        print("Could not get commit SHA")
    end
end, {
    desc = '[G]it copy [C]ommit Hash',
})

local gs = require("gitsigns")

vim.keymap.set("n", "<leader>gd", function()
    vim.cmd("tab split")
    vim.cmd("Gitsigns diffthis HEAD^")
end, { desc = "[G]it [D]iff current file with HEAD^" })

vim.keymap.set("n", "]h", gs.next_hunk, {desc = "Next Git Hunk"})
vim.keymap.set("n", "[h", gs.prev_hunk, {desc = "Prev Git Hunk"})

vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
vim.keymap.set("n", "<leader>hs", gs.stage_hunk)
vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
