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
abbr --add gvv git branch -vv
abbr --add c clear
abbr --add yd yarn dev
abbr --add yt yarn test

abbr --add .. cd ..
abbr --add ... cd ../..
abbr --add .... cd ../../..


# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 33467C
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
  
if status is-interactive
and not set -q TMUX
    exec tmux
end

starship init fish | source
