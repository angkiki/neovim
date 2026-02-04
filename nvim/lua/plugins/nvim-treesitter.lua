return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    opts = function(_, opts)
        opts.highlight = opts.highlight or {}
        opts.highlight.enable = true

        opts.indent = opts.indent or {}
        opts.indent.enable = true
    end,
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "jsx" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })

        -- Enable context-aware commenting for TSX/JSX
        require('ts_context_commentstring').setup({
            enable_autocmd = false,
        })

        -- Modern treesitter-based folding
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldcolumn = "0"
        vim.opt.foldtext = ""
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true
    end
}
