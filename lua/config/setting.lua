-- Colour scheme
vim.cmd.colorscheme("tokyonight-night")

-- Vim options
vim.opt.number = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
-- make scrolling limit the cursor before end
vim.opt.scrolloff = 15
-- enable yanking and pasting accross apps
vim.opt.clipboard = "unnamedplus"


vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- make searching centers the cursor
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Autopairs
require("nvim-autopairs").setup({})
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
)

-- Proper indentation upon saving
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "*.c",
        "*.h",
        "*.cpp",
    },
    callback = function()
        vim.lsp.buf.format()
    end,
})
