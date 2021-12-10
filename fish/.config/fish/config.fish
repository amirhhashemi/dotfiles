set fish_greeting

abbr --add gss git status -s
abbr --add glog git log --oneline --all --graph
abbr --add gcm git commit -m
abbr --add gca git commit --amend --no-edit
abbr --add gaa git add -A
abbr --add gir git rebase -i
abbr --add grc git rebase --continue
abbr --add gsp git stash pop
abbr --add gsu git stash -u
abbr --add c clear

abbr --add yd yarn dev
abbr --add yt yarn test

abbr --add .. cd ..
abbr --add ... cd ../..

if status is-interactive
and not set -q TMUX
    exec tmux
end

starship init fish | source
