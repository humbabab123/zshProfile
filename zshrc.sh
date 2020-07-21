##############################################################################
#
#   zshrc.sh
#
###############################################################################
#
#   DESCRIPTION
#       This file contains zsh startup commands to setup a user environment. 
#
#   AUTHOR
#       Jayme Wilkinson & Jeff :)
#   
#   HISTORY
#       Jul 12, 2020 - Initial Version
#       Jul 19, 2020 - Jayme Merged oh my zsh startup to this file if it 
#                      is installed.
#       Jul 20. 2020 - Jeff Added Experimental Settings 10:39PM
#
###############################################################################

################################################################################
#
#   Environment Settings
#
################################################################################
if [ -e $HOME/.environ ]; then
    source $HOME/.environ
fi


################################################################################
#
#   Alias Settings
#
################################################################################
if [ -e $HOME/.aliases ]; then
    source $HOME/.aliases
fi

#   Run my updatePath function to make sure my PATH variable is what I expect
updatePath
updatePrompt
