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
            ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
        })

        -- to handle folding
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false
    end
}
