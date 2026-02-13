return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function(plugin)
        -- Add the plugin's runtime directory to rtp so Neovim can find queries
        vim.opt.rtp:prepend(plugin.dir .. "/runtime")

        require("nvim-treesitter").install({ "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "markdown", "markdown_inline" })

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
