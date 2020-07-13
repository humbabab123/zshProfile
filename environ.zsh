
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
function designer()
{
    if [ $PLATFORM == "Linux" ]; then
        #   Make sure Substance Designer is loaded in our oz environment
        ozadd "Substance-$SUBSTANCE_DESIGNER_VERSION"

        #   Launch Substance Designer
        echo -e "\033[37;1mLaunching SubstanceDesigner-$SUBSTANCE_DESIGNER_VERSION...\033[0m"
        SubstanceDesigner

    elif [ $PLATFORM == "Darwin" ]; then
        #   Make sure Substance Designer is installed
        SUBSTANCE_DESIGNER_LOCATION="/Applications/Substance Designer.app/Contents/MacOS"

        #   Launch Substance Designer
        echo -e "\033[37;1mLaunching Substance Designer...\033[0m"
        "$SUBSTANCE_DESIGNER_LOCATION/Substance Designer"
    fi
}

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
