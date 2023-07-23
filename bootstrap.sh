#!/usr/bin/env bash

bootstrap_terminal() {
    local dotfiles_directory=$(cd "$(dirname "$0")" && pwd)

    if [ -z "$dotfiles_directory" ]; then
        echo "Error: Unable to determine the dotfiles directory!"
        exit 1
    fi

    sudo -v

    source "$dotfiles_directory/installscript" $1
}

declare -A package_managers=(
  ["ubuntu"]="apt"
  ["debian"]="apt"
  ["fedora"]="dnf"
)

os_id=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
if [ -z "$os_id" ]; then
    echo "Error: Unable to determine OS!"
    exit 1
fi

package_manager=${package_managers[$os_id]}
if [ -z "$package_manager" ]; then
    echo "Sorry, your OS is unsupported."
    exit 1
fi

if ! command -v $package_manager &> /dev/null; then
    echo "Error: Unable to detect package manager!"
    exit 1
fi

printf 'Bootstrap terminal\n'
echo '------------------'
printf "OS detected: $os_id\n"
printf "Package manager: $package_manager\n"
echo '------------------'

until [[ $reply =~ ^[YyNn]$ ]]
do
  read -rp "This will reset your terminal. Continue ? [Y/n]: " reply
done

if [[ $reply =~ ^[Nn]$ ]]
then
    printf "Aborting.\n"
    exit 1
else
    bootstrap_terminal $package_manager
fi
