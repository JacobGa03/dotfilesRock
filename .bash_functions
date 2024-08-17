# Definition of bash functions defined by the user

# Fuzzly find a file and open it in Vim 
fzvim() {
    # Default to home directory if no argument is provided
    local search_dir="${1:-$HOME}"

    # Use fzf to select a file
    local file
    # Only look at files that the user has permissions to look at
    file=$(find "$search_dir" -type f 2>/dev/null | fzf --height 40% --border)

    # Check if a file was selected
    if [ -n "$file" ]; then
        # Open the selected file in vim
        vim "$file"
    else
        echo "No file selected."
    fi
}
