return {
    'kyazdani42/nvim-tree.lua',
    config = function()
        local nt = require("nvim-tree")
        local api = require("nvim-tree.api")

        local function smart_open(node)
            if node.type == "directory" or node.nodes ~= nil then
                -- it's a folder
                api.node.open.edit(node)
                return
            end

            local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
            local real_buffers = vim.tbl_filter(function(b)
                return b.name ~= "" and not b.name:match("NvimTree_")
            end, listed_buffers)

            if #real_buffers > 0 then
                vim.cmd("tabnew")
                api.node.open.edit(node)
                vim.cmd("NvimTreeFindFile")
            end
            api.node.open.edit(node)
        end

        nt.setup({
            view = {
                width = 50, -- Width of the file explorer
            },
            git = {
                enable = true, -- Show git status icons
            },
            filters = {
                dotfiles = false, -- Show dotfiles
                git_ignored = false,
            },
            on_attach = function(bufnr)
                vim.keymap.set("n", "<CR>", function()
                    local node = api.tree.get_node_under_cursor()
                    smart_open(node)
                end, { buffer = bufnr, noremap = true, silent = true })

                -- Custom key mapping for Tab: toggle between tabs
                vim.keymap.set("n", "<Tab>", "<cmd>tabnext<CR>", { noremap = true, silent = true })
                vim.keymap.set("n", "<S-Tab>", "<cmd>tabprevious<CR>", { noremap = true, silent = true })

                -- for opening the file in a new split
                vim.keymap.set("n", "<leader>es", api.node.open.vertical, { noremap = true, silent = true })
                -- for opening the file in a new tab
                vim.keymap.set("n", "<leader>et", api.node.open.tab, { noremap = true, silent = true })
            end
        })

        -- changes nvim-tree to transparent background
        vim.cmd [[
            highlight NvimTreeNormal guibg=NONE ctermbg=NONE
            highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
        ]]

        -- for oepning and closing the nvim tree
        vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

        -- for moving the cursor in the tree to the current buffer
        vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
    end
}
