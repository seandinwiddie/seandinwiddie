# Check if shell is interactive
if status is-interactive
  # Automatically start tmux if not already in a tmux session
  # if test -z "$TMUX"
  #   tmux attach -t default || tmux new -s default
  # end

  # Conda initialization
  set -l conda_path ""
  if test -f "/Users/seandinwiddie/anaconda3/bin/conda"
    set conda_path "/Users/seandinwiddie/anaconda3"
  else if test -f "$HOME/anaconda3/bin/conda"
    set conda_path "$HOME/anaconda3"
  else if test -f "$HOME/miniconda3/bin/conda"
    set conda_path "$HOME/miniconda3"
  end

  if test -n "$conda_path"
    set __conda_setup "$($conda_path/bin/conda 'shell.fish' 'hook' 2> /dev/null)"
    if test $status -eq 0
      eval "$__conda_setup"
    else
      if test -f "$conda_path/etc/profile.d/conda.fish"
        source "$conda_path/etc/profile.d/conda.fish"
      else
        set -gx PATH "$conda_path/bin:$PATH"
      end
    end
    set -e __conda_setup
  end

  # Starship prompt initialization
  starship init fish | source
end

# pnpm
if test -d "$HOME/Library/pnpm"
  set -gx PNPM_HOME "$HOME/Library/pnpm"
else if test -d "$HOME/.local/share/pnpm"
  set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end
if set -q PNPM_HOME; and not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/usr/local/share/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/share/google-cloud-sdk/path.fish.inc'; end
# export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
# API Keys are stored securely in ~/.config/fish/conf.d/secrets.fish

# ghcup (Haskell)
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
if test -d "$HOME/.ghcup/bin"
  set -gx PATH $HOME/.cabal/bin $HOME/.ghcup/bin $PATH
end