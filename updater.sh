cp ~/.zshrc ./program_config/zsh/zsh_config.orig
cp ~/.vimrc ./program_config/vim/vim_config
cp ~/Library/Application\ Support/Kodi/userdata/favourites.xml ./program_config/kodi/favourites.xml



git add .
git commit -m "Update config files $(date)"
git push
