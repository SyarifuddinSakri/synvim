local luasnip = require("luasnip")

luasnip.config.setup({})

-- Function to check if the next character is a closing bracket
local function is_next_char_closing_bracket()
    -- Define the set of closing brackets to check
    local closing_brackets = { ")", "]", "}", ">", ";", "'", '"', ":" }

    -- Get the current cursor position (row and column)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- Get the current line of text
    local line = vim.api.nvim_get_current_line()

    -- Check if there is a next character
    if col < #line then
        -- Get the next character
        local next_char = line:sub(col + 1, col + 1)

        -- Check if the next character is a closing bracket
        for _, bracket in ipairs(closing_brackets) do
            if next_char == bracket then
                return true
            end
        end
    end

    -- Return false if no closing bracket is found
    return false
end

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = { completeopt = "menu,menuone,noinsert" },

    -- For an understanding of why these mappings were
    -- chosen, you will need to read `:help ins-completion`
    --
    -- No, but seriously. Please read `:help ins-completion`, it is really good!
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()

            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),
        --SY's
        ["<Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.confirm({ select = true })
            elseif is_next_char_closing_bracket() then
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<Right>", true, true, true),
                    "n",
                    true
                )
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
            end
        end, { "i" }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    }),
    sources = {
        {
            name = "lazydev",
            group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
vim.lsp.enable("clangd")

