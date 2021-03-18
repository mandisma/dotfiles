#!/bin/bash
#
# bootstrap installs things.

function bootstrapTerminal() {	
    DOTFILES_DIRECTORY=$(cd `dirname $0` && pwd)
    sudo -v #ask password beforehand
    source $DOTFILES_DIRECTORY/installscript
}


echo 'Bootstrap terminal'
echo '------------------'
echo 'This will reset your terminal. Are you sure you want to to this? (y/n) '
read -p 'Answer: '  reply

if [[ $reply =~ ^[Yy]$ ]]
then
   bootstrapTerminal
fi