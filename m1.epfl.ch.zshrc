# Add ~/bin
if [ -e "${HOME}/.local/bin" ]; then
    PATH="${HOME}/.local/bin:${PATH}"
fi
