set -gx https_proxy http://127.0.0.1:7897
set -gx http_proxy http://127.0.0.1:7897
set -gx all_proxy socks5://127.0.0.1:7897

set -gx EDITOR nvim

set -Ux TERM xterm-256color

set -gx SHELL /usr/local/bin/fish
