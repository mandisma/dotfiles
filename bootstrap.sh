#!/usr/bin/env bash

# define colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" # No Color

bootstrap_terminal() {
    local dotfiles_directory

    dotfiles_directory=$(cd "$(dirname "$0")" && pwd)

    if [ -z "$dotfiles_directory" ]; then
        echo -e "${RED}Error: Unable to determine the dotfiles directory!${NC}"
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
    echo -e "${RED}Error: Unable to determine OS!${NC}"
    exit 1
fi

package_manager=${package_managers[$os_id]}
if [ -z "$package_manager" ]; then
    echo -e "${RED}Sorry, your OS is unsupported.${NC}"
    exit 1
fi

if ! command -v $package_manager &> /dev/null; then
    echo -e "${RED}Error: Unable to detect package manager!${NC}"
    exit 1
fi

printf "\n${YELLOW}-------------- Bootstrap Terminal --------------${NC}\n"
printf "${GREEN}OS Detected: ${NC}$os_id\n"
printf "${GREEN}Package Manager: ${NC}$package_manager\n"
printf "${YELLOW}------------------------------------------------${NC}\n"

until [[ $reply =~ ^[YyNn]$ ]]
do
    echo -e "${YELLOW}This will reset your terminal. Continue ? [Y/n]: ${NC} \c"
    read reply
done

if [[ $reply =~ ^[Nn]$ ]]
then
    printf "${RED}Aborting.\n${NC}"
    exit 1
else
    bootstrap_terminal $package_manager
fi
