#!/usr/bin/env bash

# MigBash is the script that manages various modules
# for wide range of tasks
#
# Author: Alexander Kovalev
# Dec. 16, 2013 (last updated 01/02/2014)
# Version: 0.0.4
# ------------------------------------------------------

# MigBash config file
migbash_cfg='migbash.cfg'

# path to folder with modules
migbash_modules_path='./modules/'

# path to folder with common modules
# that will be loaded automatically
migbash_modules_common='./modules/common/'

# MigBash initialization
MigBash::init() {
    module=$1
    method=$2
    params=${@:3}
    if [[ ! -f ${migbash_cfg} ]]
    then
        echo -e "$(MigBash::color 'Config file not found...' white red)"
        exit 1
    else
        . ${migbash_cfg}
        for MODULE in $(ls ${migbash_modules_common} | grep -vE '*\.cfg|*\.ini')
        do
            . ${migbash_modules_common}${MODULE}
        done
    fi

    if [[ ! -d ${migbash_modules_path}${module} ]]
    then
        if [[ ! -f ${migbash_modules_path}${module} ]]
        then
            echo -e "$(MigBash::color 'Module not found...' white red)"
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
}

# run init
MigBash::init $*
