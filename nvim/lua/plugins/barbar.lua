return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    version = "*",
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    config = function()
        require("barbar").setup({
            animation = true,
            auto_hide = false,
            tabpages = true,
            clickable = true,
            insert_at_end = true,
            sidebar_filetypes = {
                -- for nvim-tree offset
                NvimTree = true,
            },
        })

        -- example keymaps (optional)
        local map = vim.api.nvim_set_keymap

        -- Buffer navigation
        map("n", "<Tab>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "barbar: go to next buffer" })
        map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>",
            { noremap = true, silent = true, desc = "barbar: go to previous buffer" })

        -- Move buffers
        map("n", "<leader>bm", "<Cmd>BufferMoveNext<CR>",
            { noremap = true, silent = true, desc = "barbar: move buffer right" })
        map("n", "<leader>bM", "<Cmd>BufferMovePrevious<CR>",
            { noremap = true, silent = true, desc = "barbar: move buffer left" })

        -- Close buffer
        map("n", "<leader>bd", "<Cmd>BufferClose<CR>",
            { noremap = true, silent = true, desc = "barbar: close current buffer" })

        -- Close ALL buffers
        vim.keymap.set("n", "<leader>bD", function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            end
        end, { desc = "barbar: close all buffers" })

        -- Close all other buffers
        vim.keymap.set("n", "<leader>bO", function()
            local current = vim.api.nvim_get_current_buf()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if
                    buf ~= current
                    and vim.api.nvim_buf_is_loaded(buf)
                    and vim.api.nvim_buf_get_option(buf, "buflisted")
                then
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            end
        end, { desc = "barbar: close other buffers except current buffer" })

        -- Pick buffer
        map("n", "<leader>bb", "<Cmd>BufferPick<CR>",
            { noremap = true, silent = true, desc = "barbar: trigger buffer picker" })

        -- Pin buffer
        map("n", "<leader>bp", "<Cmd>BufferPin<CR>",
            { noremap = true, silent = true, desc = "barbar: pin current buffer" })
    end,
}
