#!/bin/sh

COLOR_RED=`tput setaf 1`
COLOR_GREEN=`tput setaf 2`
COLOR_YELLOW=`tput setaf 3`
COLOR_RESET=`tput sgr0`	

#
# Common functions
#
function echoinred() { echoincolor ${COLOR_RED} $@ ; }
function echoingreen() { echoincolor ${COLOR_GREEN} $@ ; }
function echoinyellow() { echoincolor ${COLOR_YELLOW} $@ ; }
function echoincolor () {
	local COLOR=$1
	shift
	echo ${COLOR}${@}${COLOR_RESET}
}


#
# Continue function which prompts the user to see if they want to continue.  
#
# inputs: 
#     $1 => the prompt to present to the user
#
# returns:
#     0 if the user wants to continue
#     1 if the user DOES NOT want to continue
#
# example usage: 
# 
#     if asktocontinue "Do you want to run taskX?"; then echo "run taskX"; fi
# 
function asktocontinue {
	local msg=${1}
	local waitingforanswer=true
	local result=0
	while ${waitingforanswer}; do
		read -p "${COLOR_YELLOW}${msg} ('y/Y' to continue, 'n/N' to cancel)${COLOR_RESET} " -n 1 answer
		case ${answer} in
			[Yy] ) waitingforanswer=false; result=0; break;;
			[Nn] ) waitingforanswer=false; result=1; break;;
			*    ) echo ""; echo "${COLOR_RED}Please answer either yes (y/Y) or no (n/N).${COLOR_RESET}";;
		esac
	done
	echo
	return $result
}

