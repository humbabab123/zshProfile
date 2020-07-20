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
PROMPT_DIRTRIM=3

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
    
    #   Fix zsh's completion rule order for the make commando
    zstyle ':completion:*:*:make:*' tag-order 'targets'
    autoload -U compinit && compinit

fi

###############################################################################
#
#   Define BASH Specific Settings
#
###############################################################################
if [ ${BASH_VERSION} ]; then
    PROMPT_COMMAND=updatePrompt

    #  Don't put duplicate lines in the history.
    #  ... or force ignoredups and ignorespace
    HISTCONTROL=ignoredups:ignorespace
    HISTTIMEFORMAT="%Y.%m.%d %T "

    #  To setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=4500
    HISTFILESIZE=4500

    #   Append to the history file, don't overwrite it
    shopt -s histappend

    #  Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # Set VI keyboard bindings for the terminal
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

function maya()
{
    MAYA_DISABLE_CER=1
    MAYA_DISABLE_CIP=1
    MAYA_USE_MALLOC=1

    if [ $PLATFORM == "Linux" ]; then
        #   Make sure Maya is loaded in our oz environment
        if  [ `ozinfo | grep -c " - maya"` == 0 ]; then
            echo -e "\033[31;1mError: Maya is not part of the current oz environment...\033[0m"
        else
            echo -e "\033[37;1mLaunching Maya...\033[0m"
            $MAYA_LOCATION/bin/maya $@
        fi
    elif [ $PLATFORM == "Darwin" ]; then
        #   Set the MAYA_LOCATION Environment variable
        MAYA_LOCATION="/Applications/Autodesk/maya$MAYA_VERSION/Maya.app/Contents"

        echo -e "\033[37;1mLaunching Maya...\033[0m"
        $MAYA_LOCATION/bin/maya $@
    fi
}

function rv()
{
    if [ $PLATFORM == "Linux" ]; then
         #   Make sure RV is loaded in our oz environment
        if  [ `ozinfo | grep -c " - rv"` == 0 ]; then
            echo -e "\033[31;1mError: RV is not part of the current oz environment...\033[0m"
        else
            #   Launch Autodesk RV
            if [ -d $RV_LOCATION ]; then
                echo -e "\033[37;1mLaunching RV...\033[0m"
                eval "$RV_LOCATION/bin/rv $@"
            fi
        fi
    elif [ $PLATFORM == "Darwin" ]; then
        #   Set the RV_LOCATION Environment Variable
        RV_LOCATION="/Applications/RV.app/Contents/MacOS"

        #   Launch Autodesk RV
        if [ -d $RV_LOCATION ]; then
            echo -e "\033[37;1mLaunching RV...\033[0m"
            eval "$RV_LOCATION/RV $@"
        fi
    fi
}

function updatePath()
{
    #   Add $HOME/scripts to the PATH
    if [ `echo $PATH | grep -c "$HOME/scripts"` = 0 ]; then PATH="$HOME/scripts:$PATH"; fi
    
    #   Add . to the PATH
    if [ `echo $PATH | grep -c "\."` = 0 ]; then PATH=".:$PATH"; fi
    
    #   Add MacPorts folders to the PATH
    if [ `echo $PATH | grep -c "/opt/local/sbin"` = 0 ]; then PATH="/opt/local/sbin:$PATH"; fi
    if [ `echo $PATH | grep -c "/opt/local/bin"` = 0 ]; then PATH="/opt/local/bin:$PATH"; fi
}

function updatePrompt()
{
    if [ ${ZSH_VERSION} ]; then
        # Zsh prompt expansion syntax
        PS1='%B%(?.%F{green}.%F{red})%!%F{white}:%F{cyan}%n%F{yellow}@%F{cyan}%M%F{white}:%F{green}%~%F{white} > %b%f'
       
    elif [ ${BASH_VERSION} ]; then
        # Bash prompt expansion syntax
        PS1="\e[93m\]\!\[\e[97m\]:\[\e[96m\]\u\[\e[93m\]@\[\e[96m\]\h\[\e[97m\]:\[\e[32m\]\w\[\e[97m\] > \[\e[0m\]"
    fi
}

function vscode()
{
    #   Set the VSCODE_LOCATION Variable
    VSCODE_LOCATION="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

    #   Launch VSCode
    echo -e "\033[37;1mLaunching VSCode...\033[0m"
    eval "$VSCODE_LOCATION/code"
}

#   Before sending control back to the startup file make sure the path has been updated
updatePath

