# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*(/?cheat) %{
    set-option buffer filetype cheat
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=cheat %{
    require-module cheat

    #set-option window static_words %opt{cheat_static_words}

    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window cheat-.+ }
}

hook -group cheat-highlight global WinSetOption filetype=cheat %{
    add-highlighter window/cheat ref cheat
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/cheat }
}

provide-module cheat %{

    # Highlighters
    # ‾‾‾‾‾‾‾‾‾‾‾‾

    add-highlighter shared/cheat regions

    add-highlighter shared/cheat/content default-region group
    add-highlighter shared/cheat/comment region '%' '$' fill keyword
    add-highlighter shared/cheat/comment region '#' '$' fill comment
    add-highlighter shared/cheat/meta region ';' '$' fill comment
    add-highlighter shared/cheat/bracket region '<' '>' fill value

}
