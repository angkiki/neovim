return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- Auto-install missing parsers on startup
        local ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx" }
        local installed = require("nvim-treesitter.config").get_installed()
        local to_install = vim.tbl_filter(function(lang)
            return not vim.tbl_contains(installed, lang)
        end, ensure_installed)
        if #to_install > 0 then
            require("nvim-treesitter.install").install(to_install)
        end

        -- Enable context-aware commenting for TSX/JSX
        require('ts_context_commentstring').setup({
            enable_autocmd = false,
        })

        -- Treesitter-based folding (built-in to Neovim 0.11+)
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldenable = false
        vim.opt.foldlevel = 99
    end
}
