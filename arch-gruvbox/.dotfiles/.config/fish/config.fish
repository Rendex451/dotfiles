if status is-interactive
    set -gx GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH
end

set FLINE_PATH $HOME/.config/fish/fishline
source $FLINE_PATH/functions/fishline.fish
source $FLINE_PATH/themes/git_minimal.fish
