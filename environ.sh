################################################################################
#
#   environ.sh
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
#       Aug 20, 2018 - Initial Version
#       Nov 21, 2018 - Jayme - Added doc/dev aliases
#       Jul 12, 2020 - Jayme - Merged .bsh and .zsh verisons into one .sh file
#       Jul 19, 2020 - Jayme - Added logic to support ZSH and BASH commands
#
################################################################################

################################################################################
#
#   Common Environment Variables
#
################################################################################
PLATFORM=`uname`

GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=3"

###############################################################################
#
#   Git Prompt Environment Variables
#
###############################################################################
if [ -e $HOME/.git-prompt ]; then
    source $HOME/.git-prompt
    GIT_PS1_DESCRIBE_STYLE="contains"
    GIT_PS1_SHOWCOLORHINTS=True
    GIT_PS1_SHOWDIRTYSTATE=True
    GIT_PS1_SHOWUNTRACKEDFILES=True
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_STATESEPARATOR=' '
fi


###############################################################################
#
#   Define ZSH Specific Settings
#
###############################################################################
if [ ${ZSH_VERSION} ]; then    
    #   Set the prompt
    precmd() { updatePrompt; }

    #   Set some setopt settings
    setopt autocd 
    setopt autopushd
    setopt pushdignoredups
    setopt extended_history
    setopt appendhistory
    
    #   Fix zsh's completion rule order for the make commando
    zstyle ':completion:*:*:make:*' tag-order 'targets'
    autoload -U compinit && compinit

    # Set up the prompt (with git branch name)
    setopt PROMPT_SUBST

    #   Load version control information
    autoload -Uz vcs_info
    zstyle ':vcs_info:git:*' formats 'on branch %b'
 
    #   Adjust ZSH's history to be more useful like BASH
    HISTFILE=$HOME/.zsh_history
    HISTSIZE=4500
    HISTFILESIZE=4500
    SAVEHIST=4500
    HISTCONTROL=ignoredups:ignorespace
    HISTTIMEFORMAT="%Y.%m.%d %T "
    
    setopt extended_history
    setopt appendhistory

    #   Set ZSH's keyboard bindings to VI for the terminal
    bindkey -v
fi

###############################################################################
#
#   Define BASH Specific Settings
#
###############################################################################
if [ ${BASH_VERSION} ]; then
    #  Don't put duplicate lines in the history.
    #  ... or force ignoredups and ignorespace
    HISTCONTROL=ignoredups:ignorespace
    HISTTIMEFORMAT="%Y.%m.%d %T "

    #   Append to the history file, don't overwrite it
    shopt -s histappend

    #  Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    #   Set BASH's keyboard bindings to VI for the terminal
    set -o vi

    #  Make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
fi

#   Set the PROJROOT Environment Variable if the path exists
if [ -d "/Volumes/proj" ]; then
    PROJROOT="/Volumes/proj/"
fi

################################################################################
#
#   Define User's Functions
#
################################################################################
function back()
{
    #   This function creates a gzipped tarball of the file/directory supplied.
    if [ -z $1 ]; then
        echo -e "\033[37;1mA file or directory must be specified...\033[0m"
    else
        DIR="${1/\//}"
        DATE=`date "+%m%d%Y_%H%M%S"`
        TGZ=$DIR-$DATE.tgz

        echo -e "Creating Archive \033[33;1m$DIR\033[0m ---> \033[33;1m$TGZ\033[0m"
        tar cfz $TGZ $DIR
    fi
}

function clean()
{
    #   Clean up and remove all .bak files
    rm -f *.bak

    #   Clean up and remove all .tgz files
    rm -f *.tgz
}

function creator()
{
    QTCREATOR_LOCATION="/Applications/MacPorts/Qt4/Qt4\ Creator.app/Contents/MacOS"

    echo -e "\033[37mLaunching Qt Creator...\033[0m"
    eval "$QTCREATOR_LOCATION/Qt\ Creator"
}

function updatePath()
{
    #   Add $HOME/scripts to the PATH
    if [ `echo $PATH | grep -c "$HOME/scripts"` = 0 ]; then PATH="$HOME/scripts:$PATH"; fi
    
    #   Add . to the PATH
    if [ `echo $PATH | grep -c "."` = 0 ]; then PATH=".:$PATH"; fi
    
    #   Add MacPorts folders to the PATH
    if [ `echo $PATH | grep -c "/opt/local/bin"` = 0 ]; then PATH="/opt/local/bin:$PATH"; fi
    if [ `echo $PATH | grep -c "/opt/local/sbin"` = 0 ]; then PATH="/opt/local/sbin:$PATH"; fi
}

function updatePrompt()
{
    if [ ${ZSH_VERSION} ]; then
        # Zsh prompt expansion syntax
        PS1="%B%(?.%F{green}.%F{red})%!"
        PS1+="%F{white}:"
        PS1+="%F{cyan}%n"
        PS1+="%F{yellow}@"
        PS1+="%F{cyan}%m"
        PS1+="%F{white}:"
        PS1+="%F{green}%~"
        if [[ -e $HOME/.git-prompt && -e .git/config ]]; then
            PS1+="%F{white} ("
            PS1+="%F{yellow}"
            PS1+="$(__git_ps1 '%s')"
            PS1+="%F{white})"
        fi
        PS1+="%F{white} > "
        PS1+="%B"
        PS1+="%F{green}"

    elif [ ${BASH_VERSION} ]; then
        # Bash prompt expansion syntax
        local EXIT="$?"

        PS1="\001"
        PS1+="$(tput bold)"
        if [ $EXIT != 0 ]; then
            PS1+="$(tput setaf 1)\!"
        else
            PS1+="$(tput setaf 2)\!"
        fi
        PS1+="$(tput setaf 7):"
        PS1+="$(tput setaf 6)\u"
        PS1+="$(tput setaf 3)@"
        PS1+="$(tput setaf 6)\h"
        PS1+="$(tput setaf 7):"
        PS1+="$(tput setaf 2)\W"
        if [[ -e $HOME/.git-prompt && -e .git/config ]]; then
            PS1+="$(tput setaf 7) ("
            PS1+="$(tput setaf 3)"
            PS1+="$(__git_ps1 '%s')"
            PS1+="$(tput setaf 7) )"
        fi

        #   Finish the prompt
        PS1+="$(tput setaf 7) > "
        PS1+="$(tput sgr0)"
        PS1+="\002"
    fi
}

function vscode()
{
    #   Set the VSCODE_LOCATION Variable
    VSCODE_LOCATION="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

    #   Launch VSCode
    echo "\033[37;1mLaunching VSCode...\033[0m"
    eval "$VSCODE_LOCATION/code"
}

#   Before sending control back to the startup file make sure the path has been updated
updatePath
