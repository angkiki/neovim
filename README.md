# Setting Up NeoVim

### On Windows (WSL):

1. Download the Neovim Tarball from [Neovim Releases](https://github.com/neovim/neovim/releases)
2. Move the Tarball into your WSL environment (i.e. mv ../../mnt/d/Mounted_Symlink_Folder/nvim-linux-x86_64.tar.gz ~/nvim-linux-x86_64.tar.gz
3. Extract the Tarball `tar xzvf nvim-linux-x86_64.tar.gz`
4. Move the relevant nvim files to their respective location
    a. `sudo mv nvim-linux64/bin/nvim /usr/local/bin/`
    b. `sudo mv nvim-linux64/share/nvim /usr/local/share/`
    c. `sudo mv nvim-linux64/lib/nvim /usr/local/lib/`
5. Make sure `$PATH` is correctly exported `export PATH="$HOME/.local/bin:$PATH"`
6. Run neovim `nvim .` like so

### On MacOS:

1. Using homebrew `brew install neovim`
2. Run neovim `nvim .`

# Setting Up Lazy

**TLDR:** Follow the installation instructions [here](https://lazy.folke.io/installation)

After installation, you may run `:checkhealth lazy` to verify if things are working correctly

### *Side Note*:

In the installation instructions, the `lazy.setup` is quite comprehensive, but it can be simplified to:

`require("lazy").setup("plugins")`

# Checkpoint

Right now, your configuration should look like this:

```
~/.config/nvim
├── lua
│   ├── config
│   │   └── lazy.lua
└── init.lua
```

Before adding plugins, we can first setup some basic files for vim configurations, namely:

```
~/.config/nvim
├── lua
│   ├── config
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── opts.lua
│   │   └── lazy.lua
└── init.lua
```

Ensure that `init.lua` is correctly requiring the files:

```
require("config.keymaps")
require("config.opts")
require("config.lazy")
```

Now use the `opts.lua` file for changing `vim.opt` and `keymaps` file for changing `vim.keymap`.

We can now move on to plugins:

# Adding Plugins

First, we need to create the `plugins` folder, like so:

```
~/.config/nvim
├── lua
│   ├── config
│   │   └── lazy.lua
│   └── plugins
└── init.lua
```

Thereafter, we can start adding the plugin files. So for example, if you are installing `treesitter` and `telescope`, 
then it will look something like this:

```
~/.config/nvim
├── lua
│   ├── config
│   │   └── lazy.lua
│   └── plugins
│       ├── telescope.lua
│       └── treesitter.lua
└── init.lua
```

### List of "Mandatory" Plugins:

1. [conform](https://github.com/stevearc/conform.nvim) - for handling auto formatting
2. [mason](https://github.com/mason-org/mason.nvim) - for easily installing & managing LSPs, linters, formatters
3. [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - QoL plugin for auto pairs
4. [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - for handling auto completion
    a. [blink-cmp](https://github.com/Saghen/blink.cmp) - alternative consideration for auto completion
5. [nvim-surround](https://github.com/kylechui/nvim-surround) - much needed "vim surround" behaviour
6. [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) - file explorer
7. [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) - Gaze deeply into unknown regions using the power of the moon
    a. (note: can be further enhanced with ripgrep - see below)
8. [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - its just needed


### List of Optional Plugins:

1. [barbar](https://github.com/romgrk/barbar.nvim) - for maintaining that familiar IDE tabbing format
2. [git-blame](https://github.com/f-person/git-blame.nvim) - to view git blame & easily copy git permalinks
3. [git-signs](https://github.com/lewis6991/gitsigns.nvim) - signs to indicate changes (add/delete/modify) within a file
4. [lazygit](https://github.com/kdheepak/lazygit.nvim) - QoL plugin for interacting with git 
    a. (note: requires separate lazygit installation -  see below)
5. [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim) - QoL plugin for making your neovim bar look pretty
6. [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - not really optional given that it is so widely used, but purely for aesthetics
7. [toggleterm](https://github.com/akinsho/toggleterm.nvim) - QoL plugin for accessing terminal within neovim
8. [tokyonight](https://github.com/folke/tokyonight.nvim) - color scheme, for aesthetics



