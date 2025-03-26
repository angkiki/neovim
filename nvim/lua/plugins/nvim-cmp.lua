return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- Completion sources
        "hrsh7th/cmp-nvim-lsp", -- LSP completions
        "hrsh7th/cmp-buffer",   -- Buffer completions
        "hrsh7th/cmp-path",     -- Path completions
        "saadparwaiz1/cmp_luasnip", -- Snippet completions
        "L3MON4D3/LuaSnip",     -- Snippet engine
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            completion = {
                -- autocomplete = { cmp.config.window.bordered },
                autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "luasnip" },
            },
        })
    end
}
