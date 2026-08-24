local builtin = require("telescope.builtin")
local telescope = require("telescope")

telescope.setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
        },
    },
})

telescope.load_extension("ui-select")

-- Find files
vim.keymap.set("n", "<leader>sf", builtin.find_files, {desc = "[S]earch [F]iles"})

-- Search text inside files
vim.keymap.set("n", "<leader>sk", builtin.live_grep, {desc = "[S]earch [K]eyword"})

local builtin = require("telescope.builtin")

-- Normal search, prefilled with word under cursor vim.keymap.set("n", "<leader>su", function() builtin.live_grep({ default_text = vim.fn.expand("<cword>"), }) end, { desc = "[S]earch [U]nder cursor" })

-- Exact word only (-w in ripgrep)
local function search_cursor_keyword()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1

    -- Characters allowed inside the keyword
    -- Everything else acts as a separator.
    local pattern = "[%w_-]"

    -- Find beginning
    local start = col

    while start > 1 and line:sub(start - 1, start - 1):match(pattern) do
        start = start - 1
    end

    -- Find end
    local finish = col

    while finish <= #line and line:sub(finish, finish):match(pattern) do
        finish = finish + 1
    end

    local word = line:sub(start, finish - 1)

    if word == "" then
        return
    end

    builtin.grep_string({
        search = word,
    })
end

vim.keymap.set("n", "<leader>su", search_cursor_keyword, {
    desc = "[S]earch [U]nder-cursor keyword",
})

-- Search open buffers
vim.keymap.set("n", "<leader> ", builtin.buffers, {desc = "[S]earch Buffer"})

-- Search recent files
vim.keymap.set("n", "<leader>so", builtin.oldfiles, {desc = "[S]earch [O]ldfiles"})

-- Search help
vim.keymap.set("n", "<leader>oh", builtin.help_tags, {desc = "[O]pen [H]elp"})

-- Show documents symbol
vim.keymap.set("n", "<leader>sd", builtin.lsp_document_symbols, {desc = "[S]earch [D]ocument Symbol"})

-- Show workspace symbol
vim.keymap.set("n", "<leader>sw", builtin.lsp_document_symbols, {desc = "[S]earch [W]orkspace Symbol"})

-- fuzzy find keyword in the same file
vim.keymap.set("n", "<leader>sz", builtin.current_buffer_fuzzy_find, { desc = "[S]earch Fu[Z]zy" })

-- Go to Definition
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })

-- Go to References
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })

-- Go to Implementation
vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "[G]oto [I]mplementations" })

-- Set cwd to current file's directory
vim.keymap.set( "n", "<leader>rf", ":lcd %:p:h<CR>", { desc = "Change cwd to cur[R]ent [F]ile" })

-- Reload nvim config
vim.keymap.set("n", "<leader>rc", ":source $MYVIMRC<CR>", {desc = "[R]eload [C]onfig"})

-- Code Action available
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", })

--Open Quickfix list
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--Copy current file's realpath into "+" buffer
vim.keymap.set("n", "<leader>fp", function() local path = vim.fn.resolve(vim.fn.expand("%:p")) vim.fn.setreg("+", path) vim.notify("Copied:\n" .. path) end, { desc = "Copy [F]ile [P]ath to \'+\' buffer" })

vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- or '', '', etc from Nerd Font
		spacing = 2,
		severity = nil, -- show all levels
	},
	signs = true, -- show signs in the gutter
	underline = true, -- underline errors
	update_in_insert = false, -- update diagnostics in insert mode
	severity_sort = true, -- sort by severity
})

require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<leader>fe", function()
    require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h",
        select_buffer = true,
    })
end, {
    desc = "[F]ile [E]xplorer",
})

-- Show the key combinations
local wk = require("which-key").setup({})
