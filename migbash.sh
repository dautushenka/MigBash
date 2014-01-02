#!/usr/bin/env bash

# MigBash is the script that manages various modules
# for wide range of tasks
#
# Author: Alexander Kovalev
# Dec. 16, 2013 (last updated 12/28/2013)
# Version: 0.0.3
# ------------------------------------------------------

# MigBash config file
migbash_cfg='migbash.cfg'

# path to folder with modules
migbash_modules_path='./modules/'

# MigBash initialization
MigBash::init() {
    module=$1
    method=$2
    params=${@:3}
    if [[ ! -f ${migbash_cfg} ]]
    then
        echo 'Config file not found...'
        exit 1
    else
        . ${migbash_cfg}
    fi

    if [[ ! -d ${migbash_modules_path}${module} ]]
    then
        if [[ ! -f ${migbash_modules_path}${module} ]]
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
}

# run init
MigBash::init $*
