if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -f (brew --prefix)/etc/brew-wrap.fish
  source (brew --prefix)/etc/brew-wrap.fish
end

