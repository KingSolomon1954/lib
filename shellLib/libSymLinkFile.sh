# Source this file to bring function into environment
#
# Avoid double inclusion
[[ - v libSymlinkFileImported ]] && return 0
libSymlinkFileImported=1

# -----------------------------------------------------------
#
symlinkFile ()
{
    local target="$1"
    local linkName="$2"

    if [ ! -L "$linkName" ]; then
        if [ -e "$linkName" ]; then
            echo "[ERROR] $linkName exists but it's not a symlink. Please fix that manually" && exit 1
        else
            echo ln -s "$target" "$linkName"
                 ln -s "$target" "$linkName"
            echo "[OK] $linkName -> $target"
        fi
    else
        echo "[INFO] $linkName already symlinked"
    fi
}

# -----------------------------------------------------------