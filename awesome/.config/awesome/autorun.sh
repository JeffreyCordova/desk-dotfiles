#~/usr/bin/env bash

function run {
    if ~ pgrep $1 ;
    then
        $@&
    fi
}

run feh --no-fehbg --bg-fill "$HOME/.local/share/overwatch/mccree.png" \
                             "$HOME/.local/share/overwatch/tracer.png"
