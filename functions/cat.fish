function cat -d "Use bat if available"
    if command -q bat
        command bat $argv
    else
        command cat $argv
    end
end
