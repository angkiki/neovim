#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Flags ──────────────────────────────────────────────────────────────────────
USE_ALACRITTY=false
for arg in "$@"; do
    case "$arg" in
        --alacritty) USE_ALACRITTY=true ;;
        *) echo "Unknown option: $arg"; echo "Usage: $0 [--alacritty]"; exit 1 ;;
    esac
done

# ── Colours ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
info()    { echo -e "${BLUE}[info]${NC}  $*"; }
success() { echo -e "${GREEN}[ok]${NC}    $*"; }
warn()    { echo -e "${YELLOW}[warn]${NC}  $*"; }
error()   { echo -e "${RED}[error]${NC} $*" >&2; exit 1; }

# ── OS Detection ───────────────────────────────────────────────────────────────
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Detect distro
        if command -v apt &>/dev/null; then
            echo "linux-apt"
        elif command -v pacman &>/dev/null; then
            echo "linux-arch"
        else
            echo "linux-unknown"
        fi
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
info "Detected OS: $OS"

# ── Helpers ────────────────────────────────────────────────────────────────────
ensure_brew() {
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add brew to PATH for Apple Silicon
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

install_neovim_linux() {
    if command -v nvim &>/dev/null; then
        success "nvim already installed ($(nvim --version | head -1))"
        return
    fi
    info "Installing Neovim from GitHub releases..."
    local tmp; tmp=$(mktemp -d)
    local arch; arch=$(uname -m)
    local tarball="nvim-linux-${arch}.tar.gz"
    curl -Lo "$tmp/$tarball" \
        "https://github.com/neovim/neovim/releases/latest/download/$tarball"
    tar -C "$tmp" -xzf "$tmp/$tarball"
    local extracted; extracted=$(find "$tmp" -maxdepth 1 -type d -name 'nvim-*' | head -1)
    sudo cp -r "$extracted/bin/nvim" /usr/local/bin/nvim
    sudo cp -r "$extracted/share/nvim" /usr/local/share/nvim 2>/dev/null || true
    sudo cp -r "$extracted/lib/nvim"   /usr/local/lib/nvim   2>/dev/null || true
    rm -rf "$tmp"
    success "nvim installed"
}

install_lazygit_linux() {
    if command -v lazygit &>/dev/null; then
        success "lazygit already installed"
        return
    fi
    info "Installing lazygit..."
    local version; version=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
        | grep -Po '"tag_name": *"v\K[^"]*')
    local tmp; tmp=$(mktemp -d)
    curl -Lo "$tmp/lazygit.tar.gz" \
        "https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_Linux_x86_64.tar.gz"
    tar -C "$tmp" -xf "$tmp/lazygit.tar.gz" lazygit
    sudo install "$tmp/lazygit" -D -t /usr/local/bin/
    rm -rf "$tmp"
    success "lazygit installed"
}

install_nerd_font_linux() {
    local font_dir="$HOME/.local/share/fonts"
    if fc-list | grep -qi "HackNerdFont"; then
        success "Hack Nerd Font already installed"
        return
    fi
    info "Installing Hack Nerd Font..."
    mkdir -p "$font_dir"
    local tmp; tmp=$(mktemp -d)
    curl -Lo "$tmp/HackNerdFont.zip" \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
    unzip -q "$tmp/HackNerdFont.zip" -d "$font_dir/HackNerdFont"
    fc-cache -fv &>/dev/null
    rm -rf "$tmp"
    success "Hack Nerd Font installed — configure your terminal to use it"
}

# ── Install Dependencies ───────────────────────────────────────────────────────
brew_install() {
    local pkg="$1"; shift
    if brew list "$pkg" &>/dev/null; then
        success "$pkg already installed"
    else
        brew install "$@" "$pkg"
    fi
}

apt_install() {
    local pkg="$1"        # apt package name
    local cmd="${2:-$1}"  # command to check (defaults to package name)
    if command -v "$cmd" &>/dev/null; then
        success "$cmd already installed"
    else
        sudo apt-get install -y "$pkg"
    fi
}

pacman_install() {
    local pkg="$1"
    local cmd="${2:-$1}"
    if command -v "$cmd" &>/dev/null; then
        success "$cmd already installed"
    else
        sudo pacman -S --noconfirm "$pkg"
    fi
}

install_deps() {
    info "Installing dependencies..."
    case "$OS" in
        macos)
            ensure_brew
            brew_install neovim
            brew_install lazygit
            brew_install ripgrep
            brew_install fd
            brew_install font-hack-nerd-font --cask
            success "All dependencies installed"
            ;;
        wsl|linux-apt)
            sudo apt-get update -qq
            apt_install ripgrep
            apt_install fd-find fdfind
            apt_install unzip
            apt_install curl
            apt_install git
            install_neovim_linux
            install_lazygit_linux
            install_nerd_font_linux
            success "All dependencies installed"
            ;;
        linux-arch)
            pacman_install neovim
            pacman_install lazygit
            pacman_install ripgrep
            pacman_install fd
            pacman_install unzip
            pacman_install curl
            pacman_install git
            install_nerd_font_linux
            success "All dependencies installed"
            ;;
        *)
            warn "Unknown OS — skipping dependency installation. Install manually: neovim, lazygit, ripgrep, fd, a Nerd Font"
            ;;
    esac
}

# ── Symlinks ───────────────────────────────────────────────────────────────────
# Maps: <repo subdir> → <target path>
declare -A SYMLINKS=(
    ["nvim"]="$HOME/.config/nvim"
    ["kitty"]="$HOME/.config/kitty"
    ["lazygit"]="$HOME/.config/lazygit"
)
if [[ "$USE_ALACRITTY" == true ]]; then
    SYMLINKS["alacritty"]="$HOME/.config/alacritty"
fi

link_configs() {
    info "Setting up config symlinks..."
    mkdir -p "$HOME/.config"

    for src_name in "${!SYMLINKS[@]}"; do
        local src="$REPO_DIR/$src_name"
        local dest="${SYMLINKS[$src_name]}"

        # Skip if the source doesn't exist in the repo
        if [[ ! -d "$src" ]]; then
            warn "Repo dir '$src_name/' not found — skipping"
            continue
        fi

        # Already a symlink pointing to the right place
        if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
            success "$dest already linked"
            continue
        fi

        # Backup any existing real directory
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
            warn "Backing up existing $dest → $backup"
            mv "$dest" "$backup"
        elif [[ -L "$dest" ]]; then
            warn "Removing stale symlink at $dest"
            rm "$dest"
        fi

        ln -s "$src" "$dest"
        success "Linked $dest → $src"
    done
}

# ── Main ───────────────────────────────────────────────────────────────────────
echo ""
echo "  angkiki/neovim setup"
echo "  ─────────────────────"
echo ""

install_deps
link_configs

echo ""
success "Done! Open nvim and let lazy.nvim install plugins on first launch."
echo ""
