#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

ensure_brew() {
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

# ── fzf ────────────────────────────────────────────────────────────────────────
install_fzf() {
    if command -v fzf &>/dev/null; then
        success "fzf already installed"
        return
    fi
    info "Installing fzf..."
    case "$OS" in
        macos)          ensure_brew; brew install fzf ;;
        wsl|linux-apt)  sudo apt-get install -y fzf ;;
        linux-arch)     sudo pacman -S --noconfirm fzf ;;
        *) warn "Unknown OS — install fzf manually: https://github.com/junegunn/fzf#installation"; return ;;
    esac
    success "fzf installed"
}

# ── oh-my-zsh ──────────────────────────────────────────────────────────────────
install_ohmyzsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        success "oh-my-zsh already installed"
        return
    fi
    if ! command -v zsh &>/dev/null; then
        info "zsh not found — installing zsh first"
        case "$OS" in
            macos)          ensure_brew; brew install zsh ;;
            wsl|linux-apt)  sudo apt-get install -y zsh ;;
            linux-arch)     sudo pacman -S --noconfirm zsh ;;
            *) error "Unknown OS — install zsh manually first, then re-run" ;;
        esac
    fi
    info "Installing oh-my-zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    success "oh-my-zsh installed (existing .zshrc kept — merge manually if needed)"
}

# ── fd ─────────────────────────────────────────────────────────────────────────
# fcp() (zsh/functions.zsh) needs fd alongside fzf.
install_fd() {
    if command -v fd &>/dev/null; then
        success "fd already installed"
        return
    fi
    if ! command -v fdfind &>/dev/null; then
        info "Installing fd..."
        case "$OS" in
            macos)          ensure_brew; brew install fd ;;
            wsl|linux-apt)  sudo apt-get install -y fd-find ;;
            linux-arch)     sudo pacman -S --noconfirm fd ;;
            *) warn "Unknown OS — install fd manually: https://github.com/sharkdp/fd#installation"; return ;;
        esac
        success "fd installed"
    fi

    # Debian/Ubuntu ship the binary as `fdfind` (name clash w/ another package) —
    # symlink it to `fd` so functions.zsh and everything else can call it uniformly.
    if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
        mkdir -p "$HOME/.local/bin"
        ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
        case ":$PATH:" in
            *":$HOME/.local/bin:"*) ;;
            *) warn "$HOME/.local/bin not on PATH — add it so the 'fd' symlink is picked up" ;;
        esac
        success "Symlinked fdfind → fd"
    fi
}

# ── shell functions (fcp, ...) ────────────────────────────────────────────────
link_zsh_functions() {
    local src="$REPO_DIR/zsh"
    local dest="$HOME/.config/zsh"

    mkdir -p "$HOME/.config"

    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
        success "$dest already linked"
    else
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            local dir_backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
            warn "Backing up existing $dest → $dir_backup"
            mv "$dest" "$dir_backup"
        elif [[ -L "$dest" ]]; then
            rm "$dest"
        fi
        ln -s "$src" "$dest"
        success "Linked $dest → $src"
    fi

    local zshrc="$HOME/.zshrc"
    local source_line='source "$HOME/.config/zsh/functions.zsh"'

    touch "$zshrc"
    if grep -qF "$source_line" "$zshrc"; then
        success "functions.zsh already sourced in .zshrc"
        return
    fi

    local rc_backup="${zshrc}.bak.$(date +%Y%m%d%H%M%S)"
    cp "$zshrc" "$rc_backup"
    info "Backed up .zshrc → $rc_backup"

    printf '\n# angkiki/neovim tools.sh\n%s\n' "$source_line" >> "$zshrc"
    success "Wired functions.zsh into .zshrc"
}

# ── Main ───────────────────────────────────────────────────────────────────────
echo ""
echo "  angkiki/neovim tools"
echo "  ────────────────────"
echo ""

install_fzf
install_fd
install_ohmyzsh
link_zsh_functions

echo ""
success "Done!"
echo ""
