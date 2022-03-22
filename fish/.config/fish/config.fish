set fish_greeting

abbr --add ni npm install
abbr --add gs git switch
abbr --add gss git status -s
abbr --add glog git log --oneline --all --graph
abbr --add glo git log --oneline --all
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
abbr --add c clear
abbr --add yd yarn dev
abbr --add yt yarn test

abbr --add .. cd ..
abbr --add ... cd ../..
abbr --add .... cd ../../..

if status is-interactive
and not set -q TMUX
    exec tmux
end

starship init fish | source
