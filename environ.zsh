
################################################################################
#
#   .environ
#
################################################################################
#
#   DESCRIPTION
#       This file contains functions and envrionment settings
#
#   AUTHOR
#       Jayme Wilkinson
#
#   HISTORY
#       Jul 12, 2020    Initial Version for Jeff
#
################################################################################

################################################################################
#
#   Common Environment Variables
#
################################################################################
PLATFORM=`uname`

GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=3"

PROMPT_DIRTRIM=3
PROMPT_COMMAND="updatePrompt"

################################################################################
#
#   Common Environment Settings
#
################################################################################


################################################################################
#
#   Functions
#
################################################################################
function updatePath()
{
    if [ `echo $PATH | grep -c "$HOME/scripts"` == 0 ]; then PATH="$HOME/scripts:$PATH"; fi
    if [ `echo $PATH | grep -c "\."` == 0 ]; then PATH=".:$PATH"; fi
    if [ `echo $PATH | grep -c "/opt/local/sbin"` == 0 ]; then PATH="/opt/local/sbin:$PATH"; fi
    if [ `echo $PATH | grep -c "/opt/local/bin"` == 0 ]; then PATH="/opt/local/bin:$PATH"; fi
}

function updatePrompt()
{
    #   Set the command line prompt
    PS1="\e[93m\]\!\[\e[97m\]:\[\e[96m\]\u\[\e[93m\]@\[\e[96m\]\h\[\e[97m\]:\[\e[32m\]\w\[\e[97m\] > \[\e[0m\]"
}
