################################################################################
#
#   aliases.bsh
#
################################################################################
#
#   DESCRIPTION
#       This file contains useful aliases for the user.
#
#   AUTHOR
#       Jayme Wilkinson
#
#   HISTORY
#       Aug 20, 2018    Inital Version
#       Jun 01, 2019    Added support for Darwin and Linux
#       Jan 09, 2020    Reorganized file
#
################################################################################


################################################################################
#
#   Common Aliases
#
################################################################################
alias c="clear"
alias h="history"
alias j="jobs"
alias k="kill"

#   Pstree command aliases
alias ptree="pstree -cG"

#   Tree command aliases
alias tree="tree -CA"

#   Listing aliases
alias ls="/bin/ls -CFG"    
alias l="ls -la"
alias la="ls -lah"
alias ll="ls -lh"
alias lla="ls -la"
alias lt="ls -lth"
alias ltr="ls -ltrh"

#   Useful navigation aliases
alias dld="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"
alias dev="cd $HOME/Development"

alias p="pwd"

alias ssh="ssh -Y"
