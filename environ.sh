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
#       Aug 20, 2018	Initial Version
#       Oct 11, 2018	Added mstat function
#       Nov 21, 2018    Added doc/dev aliases
#       Jun 11, 2019    Added work and tool aliases
#       Jun 12, 2019    Updated completion rules
#       Jun 13, 2019    Added TotalView function
#       Oct 10, 2019    Added PostViz Oz alias
#       Jul 12, 2020    Merged .bsh and .zsh verisons into one .sh file
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

#  Don't put duplicate lines in the history.
#  ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
HISTTIMEFORMAT="%Y.%m.%d %T "

#  To setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4500
HISTFILESIZE=4500

#   Set the PROJROOT Environment Variable if the path exists
if [ -d "/Volumes/proj" ]; then
    PROJROOT="/Volumes/proj/"
fi

#  Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################################################################################
#
#   Functions
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
    #if [ `echo $PATH | grep -c "$HOME/scripts"` == 0 ]; then PATH="$HOME/scripts:$PATH"; fi
    
    #   Add . to the PATH
    #if [ `echo $PATH | grep -c "\."` == 0 ]; then PATH=".:$PATH"; fi
    
    #   Add MacPorts folders to the PATH
    PATH="/opt/local/sbin:$PATH"   # TODO: This is not ideal. Need to find a way to test the PATH
    PATH="/opt/local/bin:$PATH"
}

function updatePrompt()
{
    #   Set the command line prompt
    PS1="\e[93m\]\!\[\e[97m\]:\[\e[96m\]\u\[\e[93m\]@\[\e[96m\]\h\[\e[97m\]:\[\e[32m\]\w\[\e[97m\] > \[\e[0m\]"
}

function vscode()
{
    #   Set the VSCODE_LOCATION Variable
    VSCODE_LOCATION="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

    #   Launch VSCode
    echo -e "\033[37;1mLaunching VSCode...\033[0m"
    eval "$VSCODE_LOCATION/code"
}
