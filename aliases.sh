################################################################################
#
#   aliases.sh
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
#       Jul 12, 2020    Merged .bsh and .zsh version into one .sh file
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
alias p="pwd"

#   Pstree command aliases
alias ptree="pstree -cG"

#   Tree command aliases
alias tree="tree -CA"

#   Listing aliases
alias ls="/bin/ls -CFGh"
alias l="ls -la"
alias la="ls -la"
alias ll="ls -l"
alias lla="ls -la"
alias lt="ls -lt"
alias ltr="ls -ltr"
alias p="pwd"

#   LSF listing aliases
alias lsf="$HOME/scripts/lsf"

#   Useful navigation aliases
alias dld="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"
alias dev="cd $HOME/Development"

# Open Application aliases
alias subl="open -a Sublime\ Text.app"
alias st="subl"
alias stt="subl"
alias ofd='open_command $PWD'
