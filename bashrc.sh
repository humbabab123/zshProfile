###############################################################################
#
#   bashrc.sh
#
###############################################################################
#
#   DESCRIPTION
#       This is the bashrc startup file for bash shells
#
#   AUTHOR
#       Jayme Wilkinson
#
#   HISTORY
#       Jul 12, 2020    Initial Version
#
###############################################################################


###############################################################################
#
#   Environment Settings
#
###############################################################################
if [ -e $HOME/.environ ]; then
    source $HOME/.environ
fi


###############################################################################
#
#   Alias Settings
#
###############################################################################
if [ -e $HOME/.aliases ]; then
    source $HOME/.aliases
fi


###############################################################################
#
#   Completion Settings
#
###############################################################################
if [ -e $HOME/.bash_completion ]; then
    source $HOME/.bash_completion
fi


#   Run my updatePath function to make sure my PATH variable is what I expect
updatePath
