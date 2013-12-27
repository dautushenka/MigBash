#!/usr/bin/env bash

# MigBash is the script that manages various modules
# for wide range of tasks
#
# Author: Alexander Kovalev
# Dec. 16, 2013 (last updated 12/16/2013)
# Version: 0.0.1
# ------------------------------------------------------

# MigBash config file
migbash_cfg='migbash.cfg'

# path to folder with modules
migbash_modules_path='./modules/'

migbash_gui() {
    # check whiptail and dialog
    read dialog_type <<< "$(which whiptail dialog 2> /dev/null)"

    # use console input if whiptail and dialog weren't found
    if [[ "$dialog_type" ]]
    then
        echo "${dialog_type}"
    else
        echo "cli"
    fi
}

# just use whichever was found
#"$dialog_type" --msgbox "Message displayed with $dialog" 0 0

# MigBash initialization
migbash_init() {
    module=$1
    method=$2
    params=${@:3}
    if [ ! -f ${migbash_cfg} ]
    then
        echo 'Config file not found...'
        exit 0
    else
        . ${migbash_cfg}
    fi

    if [ ! -d ${migbash_modules_path}${module} ]
    then
        if [ ! -f ${migbash_modules_path}${module} ]
        then
            echo -en 'Module not found...\r\n'
        else
            . ${migbash_modules_path}${module}
            ${method} ${params}
        fi
    else
        for MODULE in $(ls ${migbash_modules_path}${module} | grep -vE '*\.cfg|*\.ini')
        do
            . ${migbash_modules_path}${module}/${MODULE}
        done
        ${method} ${params}
    fi
    exit 1
}

# run init
migbash_init $*
