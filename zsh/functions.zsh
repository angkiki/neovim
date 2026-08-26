# _fcp_pick <f|d> <prompt> — fuzzy-pick a file/dir via fd + fzf.
# ctrl-h toggles hidden files on/off mid-search (off by default).
# Requires: fzf, fd
_fcp_pick() {
    local type="$1" prompt="$2"
    local state; state=$(mktemp)
    echo 0 > "$state"

    local show="fd --type $type"
    local show_hidden="fd --type $type --hidden"
    local toggle="if [ \"\$(cat $state)\" = 0 ]; then echo 1 > $state; $show_hidden; else echo 0 > $state; $show; fi"

    local result
    result=$(eval "$show" | fzf --prompt="$prompt" \
        --header 'ctrl-h: toggle hidden files' \
        --bind "ctrl-h:reload($toggle)")

    rm -f "$state"
    echo "$result"
}

# fcp — fuzzy-pick a file and a destination dir, then copy.
# Requires: fzf, fd
fcp() {
    if ! command -v fzf &>/dev/null || ! command -v fd &>/dev/null; then
        echo "fcp: requires fzf and fd — run tools.sh to install them" >&2
        return 1
    fi

    local src dest
    src=$(_fcp_pick f "copy: ")
    [[ -z "$src" ]] && return 1

    dest=$(_fcp_pick d "to: ")
    [[ -z "$dest" ]] && return 1

    cp -v "$src" "$dest"
}

# fcd — fuzzy-pick a directory and cd into it.
# Requires: fzf, fd
fcd() {
    if ! command -v fzf &>/dev/null || ! command -v fd &>/dev/null; then
        echo "fcd: requires fzf and fd — run tools.sh to install them" >&2
        return 1
    fi

    local dir
    dir=$(_fcp_pick d "cd: ")
    [[ -z "$dir" ]] && return 1

    cd "$dir"
}
