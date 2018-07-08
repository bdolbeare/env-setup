# This is a hack that allows you to source a customized script prior to running the rest 
#  of this .bash_profile script.  This is necessary on one of the machines I use because
#  I don't have root access to that machine and therefore can't update /etc/shells to 
#  include bash 4 shell (which I want).  As a workaround, I introduced a .bash_profile_pre
#  script so that I can run the following command to exec a bash 4 shell. 
#
# if echo ${BASH_VERSION} | egrep '^3' > /dev/null 2>&1 ; then exec ${HOMEBREW}/bin/bash; fi
#

if [ -f ~/.bash_profile_pre ]; then
	source ~/.bash_profile_pre
fi

source ~/.bashrc
