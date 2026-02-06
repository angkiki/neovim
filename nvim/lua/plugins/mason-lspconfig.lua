return {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.0.0",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_enabled = false,
            ensure_installed = { "lua_ls", "ts_ls" } -- Auto-install these
        })
    end
}
