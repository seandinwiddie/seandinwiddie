# Check if shell is interactive
if status is-interactive
  # Automatically start tmux if not already in a tmux session
  # if test -z "$TMUX"
  #   tmux attach -t default || tmux new -s default
  # end

  # Conda initialization
  if test -f "/Users/seandinwiddie/anaconda3/bin/conda"
    set __conda_setup "$('/Users/seandinwiddie/anaconda3/bin/conda' 'shell.fish' 'hook' 2> /dev/null)"
    if test $status -eq 0
      eval "$__conda_setup"
    else
      if test -f "/Users/seandinwiddie/anaconda3/etc/profile.d/conda.fish"
        source "/Users/seandinwiddie/anaconda3/etc/profile.d/conda.fish"
      else
        set -gx PATH "/Users/seandinwiddie/anaconda3/bin:$PATH"
      end
    end
    set -e __conda_setup
  end

  # Starship prompt initialization
  starship init fish | source
end

# Added by Windsurf
fish_add_path /Users/seandinwiddie/.codeium/windsurf/bin

# pnpm
set -gx PNPM_HOME "/Users/seandinwiddie/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/usr/local/share/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/share/google-cloud-sdk/path.fish.inc'; end
# export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
# API Keys are stored securely in ~/.config/fish/conf.d/secrets.fish

# Added by Antigravity
fish_add_path /Users/seandinwiddie/.antigravity/antigravity/bin

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/seandinwiddie/.ghcup/bin $PATH # ghcup-env