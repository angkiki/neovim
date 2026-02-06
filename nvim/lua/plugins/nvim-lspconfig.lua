return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
            capabilities = capabilities,
        })

        vim.lsp.config('ts_ls', { capabilities = capabilities })
        vim.lsp.config('eslint', { capabilities = capabilities })

        vim.lsp.config('pyright', {
            settings = {
                python = {
                    analysis = {
                        extraPaths = { vim.fn.getcwd() }
                    }
                }
            },
            capabilities = capabilities,
        })

        vim.lsp.config('taplo', { capabilities = capabilities })

        vim.lsp.enable({ 'lua_ls', 'ts_ls', 'eslint', 'pyright', 'taplo' })

        -- Keybindings
        vim.keymap.set("n", "gd", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
        end, { desc = "Go to definition" })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover docs" })
        -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
    end
}
