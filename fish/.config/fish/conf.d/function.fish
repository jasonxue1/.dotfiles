function mkcd
  mkdir -p $argv && cd $argv
end

# py venv
function auto_activate_venv --on-variable PWD
    # 如果当前目录下有 .venv（或 venv）文件夹，就激活它
    if test -d .venv
        source .venv/bin/activate.fish
    else if test -d venv
        source venv/bin/activate.fish

    # 否则如果已经有激活的 VIRTUAL_ENV，就停用它
    else if set -q VIRTUAL_ENV
        deactivate
    end
end
