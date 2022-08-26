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
    # Tags
    add-highlighter shared/cheat/title region '^%' '$' fill magenta
    # Import tags
    add-highlighter shared/cheat/import region '^@' '$' fill cyan
    # Command descriptions
    add-highlighter shared/cheat/comment region '^#' '$' fill comment
    # Meta-comments, ignored
    add-highlighter shared/cheat/meta region '^;' '$' fill comment
    # Variables
    add-highlighter shared/cheat/reference region '<' '>' fill value
    # Defining varables, generates lists of possible values
    add-highlighter shared/cheat/content/ regex (?<=\$\s)\w+ 0:value
    # Customize fzf behavior e.g. --- --column 3
    add-highlighter shared/cheat/content/ regex (?<=\s)-{3}(?=\s).* 0:yellow+i
}

