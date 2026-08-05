require("gitsigns").setup({
    current_line_blame = true,
})

vim.keymap.set("n", "<leader>gb", function()
    require("gitsigns").blame_line({ full = true })
end, {
    desc = "[G]it [B]lame line",
})

local gs = require("gitsigns")

vim.keymap.set("n", "]h", gs.next_hunk, {desc = "Next Git Hunk"})
vim.keymap.set("n", "[h", gs.prev_hunk, {desc = "Prev Git Hunk"})

vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
vim.keymap.set("n", "<leader>hs", gs.stage_hunk)
vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
