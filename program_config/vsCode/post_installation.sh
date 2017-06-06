

if [[ `uname` == "Darwin" ]]; then
    open -a "Visual Studio Code"
fi


printf '\e[1;46m%-6s\e[m\n' "install the 'Setting Sync' extension and then open the Command Palette, type Sync download and paste the following token" 
lpass show 'code_sync Token(vscode)' | grep -o 'Token: .*'

# printf '\e[1;33m%-6s\e[m' "install the 'Setting Sync' extension and then"

