set fish_greeting

# vim mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
bind --mode insert --sets-mode default jk repaint

# https://github.com/sindresorhus/trash-cli
abbr --add rm trash
abbr --add c clear
abbr --add nv nvim
abbr --add .. cd ..
abbr --add ... cd ../..
abbr --add pn pnpm
abbr --add gs git switch
abbr --add gss git status -s
abbr --add glog git log --oneline --all --graph --decorate
abbr --add glo git log --oneline --all
abbr --add grs git restore --staged .
abbr --add gcm git commit -m
abbr --add gcam git commit -am
abbr --add gca git commit --amend --no-edit
abbr --add gaa git add -A
abbr --add gir git rebase -i
abbr --add grc git rebase --continue
abbr --add gra git rebase --abort
abbr --add gsp git stash pop
abbr --add gsu git stash -u
abbr --add gdc git diff-tree --no-commit-id --name-status -r
abbr --add gvv git branch -vv

set -gx PNPM_HOME /home/amir/.local/share/pnpm
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH $PNPM_HOME $PATH
end

set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin /usr/local/go/bin $PATH

set -gx BUN_INSTALL $HOME/.bun
set -gx PATH $BUN_INSTALL/bin $PATH

set -gx PATH ~/.local/bin $PATH

zoxide init fish | source

jj util completion fish | source

fzf --fish | source

set -gx FZF_DEFAULT_OPTS --layout=reverse
set -gx FZF_CTRL_T_OPTS --walker-skip .git,node_modules
