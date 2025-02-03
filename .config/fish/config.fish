if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx HOMEBREW_BUNDLE_FILE ~/.config/brewfile/Brewfile
set -gx AWS_CLI_AUTO_PROMPT on
set -gx AWS_PAGER
set -gx AWS_DEFAULT_OUTPUT table
set -gxa fish_user_paths $(realpath ~/.deno/bin)

