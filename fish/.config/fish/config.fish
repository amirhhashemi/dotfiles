# =============================================================================
# Basic Settings
# =============================================================================

# Disable the default greeting message
set fish_greeting

# Set the default editor (use nvim if available, otherwise fallback)
if command -v nvim > /dev/null
    set -gx EDITOR nvim
else if command -v vim > /dev/null
    set -gx EDITOR vim
else if command -v vi > /dev/null
    set -gx EDITOR vi
end

# =============================================================================
# PATH Management
# =============================================================================

# Add local bin directory
fish_add_path "$HOME/.local/bin"

# Add Go paths
fish_add_path "/usr/local/go/bin"
fish_add_path "$HOME/go/bin"

# Add Zig path
fish_add_path "$HOME/zig"

# Add Bun path
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path "$BUN_INSTALL/bin"

# Add pnpm path
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path "$PNPM_HOME"

# =============================================================================
# Vi Mode Configuration
# =============================================================================

fish_vi_key_bindings

# Customize cursors for different Vim modes
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# Use jk to exit insert mode
bind --mode insert --sets-mode default jk repaint

# Use clipboard for copy and paste operations
bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind y,\$ fish_clipboard_copy
bind y,\^ fish_clipboard_copy
bind y,0 fish_clipboard_copy
bind y,w fish_clipboard_copy
bind y,W fish_clipboard_copy
bind y,i,w forward-single-char forward-single-char backward-word fish_clipboard_copy
bind y,i,W forward-single-char forward-single-char backward-bigword fish_clipboard_copy
bind y,a,w forward-single-char forward-single-char backward-word fish_clipboard_copy
bind y,a,W forward-single-char forward-single-char backward-bigword fish_clipboard_copy
bind y,e fish_clipboard_copy
bind y,E fish_clipboard_copy
bind y,b fish_clipboard_copy
bind y,B fish_clipboard_copy
bind y,g,e fish_clipboard_copy
bind y,g,E fish_clipboard_copy
bind y,f begin-selection forward-jump fish_clipboard_copy end-selection
bind y,t begin-selection forward-jump-till fish_clipboard_copy end-selection
bind y,F begin-selection backward-jump fish_clipboard_copy end-selection
bind y,T begin-selection backward-jump-till fish_clipboard_copy end-selection
bind y,h backward-char begin-selection fish_clipboard_copy end-selection
bind y,l begin-selection fish_clipboard_copy end-selection
bind y,i,b jump-till-matching-bracket and jump-till-matching-bracket and begin-selection jump-till-matching-bracket fish_clipboard_copy end-selection
bind y,a,b jump-to-matching-bracket and jump-to-matching-bracket and begin-selection jump-to-matching-bracket fish_clipboard_copy end-selection
bind y,i backward-jump-till and repeat-jump-reverse and begin-selection repeat-jump fish_clipboard_copy end-selection
bind y,a backward-jump and repeat-jump-reverse and begin-selection repeat-jump fish_clipboard_copy end-selection
bind -M visual -m default y fish_clipboard_copy end-selection repaint-mode
bind p 'set -g fish_cursor_end_mode exclusive' forward-char 'set -g fish_cursor_end_modefish_cursor_end_modeinclusive' fish_clipboard_paste
bind P fish_clipboard_paste

# ==============================================================================
# Abbreviations
# ==============================================================================

# General
abbr --add rm trash
abbr --add c clear
abbr --add nv nvim
abbr --add .. cd ..
abbr --add ... cd ../..
abbr --add pn pnpm

# Git Abbreviations
abbr --add gs git switch
abbr --add gss git status -s
abbr --add glog git log --oneline --all --graph --decorate
abbr --add glo git log --oneline --all
abbr --add gaa git add -A
abbr --add gcm git commit -m
abbr --add gcam git commit -am
abbr --add gca git commit --amend --no-edit
abbr --add gr git restore .
abbr --add grs git restore --staged .
abbr --add gir git rebase -i
abbr --add grc git rebase --continue
abbr --add gra git rebase --abort
abbr --add gsp git stash pop
abbr --add gsu git stash -u
abbr --add gvv git branch -vv
abbr --add gpf git push --force-with-lease
abbr --add gp git pull
abbr --add gpr git pull --rebase

# ==============================================================================
# Tool Initializations
# ==============================================================================

# fzf (fuzzy finder) - https://github.com/junegunn/fzf
if command -v fzf > /dev/null
    fzf --fish | source
    # Layout: results on top
    set -gx FZF_DEFAULT_OPTS "--layout=reverse $FZF_DEFAULT_OPTS"
    # Ctrl+T options: Don't search inside .git or node_modules
    set -gx FZF_CTRL_T_OPTS "--walker-skip .git,node_modules $FZF_CTRL_T_OPTS"
end

# zoxide (smarter cd) - https://github.com/ajeetdsouza/zoxide
if command -v zoxide > /dev/null
    zoxide init fish | source
end

# =============================================================================
# Secrets Management (Example: Bitwarden Secrets Manager)
# =============================================================================

# Load Bitwarden Secrets Manager access token from GNOME Keyring/Secret Service
# Only run in interactive shells where secret-tool is available
if status is-interactive; and command -v secret-tool > /dev/null
    # Ensure the keyring is available; might prompt for password
    # The lookup might fail if the keyring is locked, handle gracefully
    # Use command substitution with Piped Process Substitution for better error handling
    set -l token (secret-tool lookup bws access-token 2>/dev/null)
    if test $status -eq 0; and test -n "$token"
        set -gx BWS_ACCESS_TOKEN "$token"
    else
        # Only show warning if the lookup command actually failed, not just returned empty
        if test $status -ne 0
            echo "Warning: Failed to retrieve BWS_ACCESS_TOKEN from keyring (status: $status)." >&2
        end
    end
    # Erase the temporary local variable securely
    set -e token
end
