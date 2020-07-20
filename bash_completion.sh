###############################################################################
#
#   bash_completion.sh
#
###############################################################################
#
#   DESCRIPTION
#       This file contains completion functions and rules for the bash shell.
#
#   AUTHOR
#       Jayme Wilkinson
#
#   HISRTORY
#       Jun 20, 2020 - Initial Version
#       Jul 19, 2020 - Added File banner to file
#
###############################################################################

###############################################################################
#
#   Define the bash completion functions used by the completion here
#
###############################################################################
_make()
{
    if [ "${#COMP_WORDS[@]}" != "2" ]; then
        return
    fi

    local commands_number=${DOTHIS_COMPLETION_COMMANDS_NUMBER:-50}
    local IFS=$'\n'
    local suggestions=()
    
    if [ "${#suggestions[@]}" == "1" ]; then
        local number="${suggestions[0]/%\ */}"
        COMPREPLY=("$number")
    else
        for i in "${!suggestions[@]}"; do
            suggestions[$i]="$(printf '%*s' "-$COLUMNS"  "${suggestions[$i]}")"
        done

        COMPREPLY=("${suggestions[@]}")
    fi
}


###############################################################################
#
#   Define the bash completion rules here
#
###############################################################################
complete -F _make make
