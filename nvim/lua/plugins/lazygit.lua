-- nvim v0.8.0
-- this only works if you have lazy git installed on your system
-- for WSL on windows:
-- LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
-- curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
-- tar xf lazygit.tar.gz lazygit
-- sudo install lazygit -D -t /usr/local/bin/
--
-- for macOS
-- brew install lazygit
return {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- on macOS, lazygit when installed via homebrew is installed in $HOME/Library/Application Support/
        -- but the default behaviour of linux is to look for the config in ~/.config/lazygit/config.yml
        -- to ensure that the config is easily clonable, we will make sure to specfiy where the config is
        vim.g.lazygit_use_custom_config_file_path = 1
        vim.g.lazygit_config_file_path = vim.fn.expand("~/.config/lazygit/config.yml")

        -- Function to open a file from lazygit and close lazygit window
        _G.lazygit_open_file = function(filepath)
            vim.schedule(function()
                -- Switch to the previous window (not the terminal)
                vim.cmd('wincmd p')
                -- Find and close all lazygit terminal buffers
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_valid(buf) then
                        local bufname = vim.api.nvim_buf_get_name(buf)
                        if bufname:match("lazygit") then
                            vim.api.nvim_buf_delete(buf, { force = true })
                        end
                    end
                end
                -- Open the file as a buffer
                vim.cmd('edit ' .. vim.fn.fnameescape(filepath))
            end)
        end
    end,
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "lazygit: open lazy git window" },
    },
}
