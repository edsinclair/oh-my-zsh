PROMPT='$(timetrap_status) %{$fg_bold[green]%}%p%{$fg[cyan]%}%c %{$fg[red]%}‹$RUBY_VERSION› %{$fg_bold[blue]%}$(git_prompt_info) % %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="› %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="›%{$fg[green]%} ✓"

ZSH_THEME_TIMETRAP_PROMPT_IN="%{$fg[green]%}◉%{$reset_color%}"
ZSH_THEME_TIMETRAP_PROMPT_OUT="%{$fg[red]%}◉%{$reset_color%}"
