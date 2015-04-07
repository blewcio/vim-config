#!/bin/sh

VIM_DIR=".vim"
VIMRC=".vimrc"

ERROR_COLOR='\033[0;31m'
WARNING_COLOR='\033[0;33m'
NO_COLOR='\033[0m'

# Link the main directory
TARGET=$HOME/$VIM_DIR
if [ -e $TARGET ]; then
  BACKUP="${TARGET}~"
  echo "** ${WARNING_COLOR}Warning${NO_COLOR}: Directory exists, backing up to ${BACKUP}"
  mv $TARGET $BACKUP
  unset BACKUP
fi

ln -s $PWD/$VIM_DIR $TARGET
unset TARGET

# Link vimrc
TARGET=$HOME/$VIMRC
echo $TARGET
if [ -e $TARGET ]; then
  BACKUP="${TARGET}~"
  echo "** ${WARNING_COLOR}Warning${NO_COLOR}: File exists, backing up to ${BACKUP}"
  mv $TARGET $BACKUP
  unset BACKUP
fi

ln -s $PWD/$VIMRC $TARGET
unset TARGET

# Download plugins with Vundle
vim +PluginInstall +qall
