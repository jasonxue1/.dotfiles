
# 设置conda配置路径
export CONDARC=~/.config/conda/environments.txt

# 设置代理
export https_proxy=http://127.0.0.1:7897
export http_proxy=http://127.0.0.1:7897
export all_proxy=socks5://127.0.0.1:7897

# 设置DBUS地址
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"


# 设置默认编辑器
export EDITOR="nvim"

# 配置终端颜色和提示符
export PS1="%n@%m:%~%# "

# 设置语言环境
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# 设置程序路径（合并所有路径设置）
export PATH="$HOME/bin:/usr/local/bin:/Library/TeX/texbin:/usr/local/Cellar/mupdf/1.25.4/bin:/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:/Applications/ltex-ls-16.0.0/bin:$PATH"

# 设置终端类型
export TERM="xterm-256color"
