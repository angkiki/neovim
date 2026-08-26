# fcp — fuzzy-pick a file and a destination dir, then copy.
# Requires: fzf, fd
fcp() {
    if ! command -v fzf &>/dev/null || ! command -v fd &>/dev/null; then
        echo "fcp: requires fzf and fd — run tools.sh to install them" >&2
        return 1
    fi

    local src dest
    src=$(fd --type f --hidden --exclude .git | fzf --prompt="copy: ")
    [[ -z "$src" ]] && return 1

    dest=$(fd --type d --hidden --exclude .git | fzf --prompt="to: ")
    [[ -z "$dest" ]] && return 1

    cp -v "$src" "$dest"
}
