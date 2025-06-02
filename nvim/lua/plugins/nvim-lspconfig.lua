return {
    "neovim/nvim-lspconfig",
    config = function()
        -- local cmp = require("cmp")
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Example: Configure Lua language server
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
            capabilities = capabilities
        })

        -- Example: Configure TypeScript server
        lspconfig.ts_ls.setup({})
        lspconfig.eslint.setup({ capabilities = capabilities })


        -- Python
        lspconfig.pyright.setup({
            settings = {
                python = {
                    analysis = {
                        extraPaths = { vim.fn.getcwd() }
                    }
                }
            }
        })
        lspconfig.taplo.setup({})

        -- Add keybindings
        vim.keymap.set("n", "gd", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
        end, { desc = "Go to definition" })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover docs" })
        -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
    end
}
