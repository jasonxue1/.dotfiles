zmodload zsh/zprof

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && source $(brew --prefix)/etc/profile.d/autojump.sh

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit light unixorn/fzf-zsh-plugin
zinit light zsh-users/zsh-completions
