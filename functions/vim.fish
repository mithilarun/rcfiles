function vim -d "Use neovim if available"
    if command -q nvim
        command nvim $argv
    else
        command vim $argv
    end
end

function vi -d "Use neovim if available"
    if command -q nvim
        command nvim $argv
    else
        command vi $argv
    end
end
