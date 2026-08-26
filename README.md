# angkiki/neovim

A personal Neovim config (and friends). This repo manages configs for:

| Tool | Config location |
|------|----------------|
| [Neovim](https://neovim.io) | `nvim/` |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | `kitty/` |
| [Lazygit](https://github.com/jesseduffield/lazygit) | `lazygit/` |
| [Alacritty](https://alacritty.org) | `alacritty/` *(optional, see below)* |
| zsh functions (`fcp`, ...) | `zsh/` *(optional, see [QoL Shell Tools](#qol-shell-tools))* |
| fd global ignore rules | `fd/` *(optional, see [QoL Shell Tools](#qol-shell-tools))* |

## Quick Start

Clone the repo and run the setup script:

```bash
git clone git@github.com:angkiki/neovim.git ~/neovim
cd ~/neovim
chmod +x setup.sh && ./setup.sh
```

The script will:
1. **Install dependencies** — `neovim`, `lazygit`, `ripgrep`, `fd`, Hack Nerd Font (macOS via Homebrew; Linux via apt/pacman + GitHub releases)
2. **Symlink configs** — `nvim`, `kitty`, and `lazygit` are symlinked to `~/.config/` automatically. Existing configs are backed up with a timestamp.

To also link the Alacritty config, pass `--alacritty`:

```bash
./setup.sh --alacritty
```

After that, open `nvim` and `lazy.nvim` will install all plugins on first launch.

> **Note:** Nerd Fonts require manual terminal configuration after installation. See [Nerd Font setup](#nerd-font-setup) below.

---

## How the Symlinks Work

Instead of copying config files in and out of the repo, `setup.sh` creates symlinks:

```
~/.config/nvim      →  ~/angkiki_neovim/nvim/
~/.config/kitty     →  ~/angkiki_neovim/kitty/
~/.config/lazygit   →  ~/angkiki_neovim/lazygit/
~/.config/alacritty →  ~/angkiki_neovim/alacritty/
```

Any change you make in `~/.config/nvim` is a change in this repo — just `git commit` and push.

---

## QoL Shell Tools

`tools.sh` is separate from `setup.sh` — it's optional shell tooling, not required for Neovim to work. Idempotent (safe to re-run) and OS-aware, same as `setup.sh`.

```bash
./tools.sh
```

It will:
1. **Install `fzf` and `fd`** — via Homebrew/apt/pacman. On Debian/Ubuntu the `fd-find` package installs its binary as `fdfind`; `tools.sh` symlinks it to `~/.local/bin/fd` so it's callable the same way everywhere.
2. **Symlink `fd/ignore` → `~/.config/fd/ignore`** — `fd` always reads this file (gitignore syntax) regardless of `--hidden`, so noisy dirs (`node_modules`, `.cache`, `.cargo`, build output, ...) stay out of every `fd` search, including `fcp`'s. Edit `fd/ignore` in the repo to add more.
3. **Install [oh-my-zsh](https://ohmyz.sh/)** — non-interactively (`RUNZSH=no CHSH=no KEEP_ZSHRC=yes`), so your existing `.zshrc` is left in place.
4. **Symlink `zsh/` → `~/.config/zsh`** and add a `source` line to `.zshrc` (backed up first, and only added once).

This gives you two shell functions built on `fd` + `fzf`, so you never have to type or remember full paths:

- **`fcp`** — fuzzy-pick a source file and a destination directory, then copy:
  ```bash
  fcp
  # copy: <fuzzy-search files>
  # to:   <fuzzy-search dirs>
  ```
- **`fcd`** — fuzzy-pick a directory and `cd` into it:
  ```bash
  fcd
  # cd: <fuzzy-search dirs>
  ```

Hidden files/dirs (dotfiles) are off by default in each picker — press **ctrl-h** to toggle them on, ctrl-h again to hide them.

More shell functions can be added to `zsh/functions.zsh` over time — re-run `tools.sh` to pick up the symlink if it's missing, no need to touch `.zshrc` again.

---

## Neovim Config Structure

```
nvim/
├── init.lua                  # entry point
├── lazy-lock.json            # plugin lockfile
├── lsp/                      # per-LSP server configs
│   ├── eslint.lua
│   ├── lua_ls.lua
│   ├── pyright.lua
│   └── ts-ls.lua
└── lua/
    ├── config/
    │   ├── init.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   ├── lsp.lua
    │   └── opts.lua
    └── plugins/              # one file per plugin
        ├── barbar.lua
        ├── blink.lua
        ├── conform.lua
        ├── mason.lua
        ├── telescope.lua
        ├── nvim-treesitter.lua
        └── ...
```

### Plugins

**Core:**
- [blink.cmp](https://github.com/Saghen/blink.cmp) — autocompletion
- [conform.nvim](https://github.com/stevearc/conform.nvim) — formatting
- [mason.nvim](https://github.com/mason-org/mason.nvim) — LSP/linter/formatter installer
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) — file explorer
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) — fuzzy finder (enhanced with ripgrep)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — syntax highlighting & parsing

**QoL:**
- [barbar.nvim](https://github.com/romgrk/barbar.nvim) — tabline
- [git-blame.nvim](https://github.com/f-person/git-blame.nvim) — inline blame & git permalinks
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — diff signs in the gutter
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) — lazygit inside nvim
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — statusline
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) — auto bracket pairs
- [nvim-surround](https://github.com/kylechui/nvim-surround) — surround motions
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) — terminal toggle
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) — colour scheme
- [which-key.nvim](https://github.com/folke/which-key.nvim) — keybind hints

---

## Manual Installation

If you prefer not to use `setup.sh`, here are the steps by platform.

### Neovim

**macOS:**
```bash
brew install neovim
```

**Linux (apt):**
```bash
# apt ships an outdated version — install from tarball instead
curl -Lo nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzf nvim.tar.gz
sudo mv nvim-linux-x86_64/bin/nvim /usr/local/bin/
```

**Windows (WSL):**
Same as Linux above. Move the tarball into WSL first:
```bash
mv /mnt/d/.../nvim-linux-x86_64.tar.gz ~/
```

### Lazygit

**macOS:**
```bash
brew install lazygit
```

**Linux / WSL:**
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
```

### Ripgrep & fd

**macOS:**
```bash
brew install ripgrep fd
```

**Linux (apt):**
```bash
sudo apt install ripgrep fd-find
```

**Linux (arch):**
```bash
sudo pacman -S ripgrep fd
```

---

## Nerd Font Setup

The config uses [Hack Nerd Font](https://www.nerdfonts.com/font-downloads).

**macOS:**
```bash
brew install --cask font-hack-nerd-font
```
Then set `font_family HackNerdFont` in `kitty/kitty.conf` (or equivalent for your terminal).

**Linux:**
`setup.sh` downloads and installs the font to `~/.local/share/fonts/`. After that, configure your terminal emulator to use `HackNerdFont`.

**WSL:**
Download [Hack Nerd Font](https://www.nerdfonts.com/font-downloads), install it in Windows (double-click the `.ttf` files), then select it in your WSL terminal settings.
