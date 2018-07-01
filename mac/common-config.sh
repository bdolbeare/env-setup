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
# Common
# 

export EDITOR=vi

if command -v most > /dev/null 2>&1; then
    export PAGER="most"
fi

#
# Java
#

function javahome () {
  local version=$1 
  export JAVA_HOME=$(/usr/libexec/java_home -v ${version})
  echo "JAVA_HOME:" $JAVA_HOME
  java -version
}

alias java8='javahome 1.8'
alias java9='javahome 9'
alias java10='javahome 10'
