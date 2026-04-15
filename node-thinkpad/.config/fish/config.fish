if status is-interactive
    # Commands to run in interactive sessions can go here
end

function plkstart
    nohup /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 > /dev/null 2>&1 &
end
