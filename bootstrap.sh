#!/usr/bin/env bash

function bootstrapTerminal() {
    DOTFILES_DIRECTORY=$(cd "$(dirname "$0")" && pwd)
    sudo -v #ask password beforehand
    source "$DOTFILES_DIRECTORY/installscript" $1
}

declare -A packageManagers;
packageManagers[ubuntu]=apt
packageManagers[debian]=apt
packageManagers[fedora]=dnf

OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
PACKAGE_MANAGER=$(echo ${packageManagers[$OS_ID]})

if ! command -v $PACKAGE_MANAGER &> /dev/null; then
    echo "Aborting! Unable to detect package manager."
    exit 1
fi

echo 'Bootstrap terminal'
echo '------------------'
echo "OS detected: $OS_ID"
echo "Package manager: $PACKAGE_MANAGER"
echo '------------------'
echo 'This will reset your terminal. Are you sure you want to to this? (y/n) '
read -p 'Answer: '  reply

if [[ $reply =~ ^[Yy]$ ]]
then
    bootstrapTerminal $PACKAGE_MANAGER
fi