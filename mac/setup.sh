#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# Pull in some common functions
. ./common-functions.sh

echoingreen "This script will update files in your home directory with standard versions from the git repo (e.g. .bashrc, .gitconfig, etc)."
echoingreen "Note: A backup file will be created in the target directory for any file that already exists" 

files=()
files+=('.bashrc')
files+=('.bash_profile')
files+=('.exports')
files+=('.aliases')
files+=('.functions')
files+=('.inputrc')
files+=('.gitconfig')
files+=('.colordiffrc')
files+=('.vimrc')
files+=('.screenrc')
files+=('.tmux.conf')
files+=('.bin')
files+=('.tmuxinator')

BACKUPDIR=${HOME}/backups
mkdir ${BACKUPDIR} > /dev/null 2>&1

function syncfile() {
	local file=$1
	rsync -avhb --suffix="$(date +'%Y%m%d-%H%M%S')" --no-perms --backup-dir=$BACKUPDIR $file ~
}

FORCE=false
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	FORCE=true
else
	echo 
	sleep 2
	FORCE=false
fi

for file in ${files[@]}; do
	echo "-------------------------"
	echo Working on file $file

	if $FORCE ; then
		syncfile $file
	else
		# Show file diffs
		if [ -f ~/$file ]; then
			echoinyellow "${HOME}/${file} already exists."
			echoinyellow "diff $file ~/$file | less"
			diff $file ~/$file | more
		fi

		# Ask to continue
		if asktocontinue "Do you want to replace copy $file to your home directory?"; then
			syncfile $file
		fi
		echo 
	fi
done
