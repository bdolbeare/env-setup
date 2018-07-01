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
