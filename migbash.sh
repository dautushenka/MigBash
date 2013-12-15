#!/usr/bin/env bash

# MigBash is the script that manages various modules
# for wide range of tasks
# Author: Alexander Kovalev
# Dec. 16, 2013 (last updated 12/16/2013)

# MigBash config file
migbash_cfg='migbash.cfg'

# path to folder with modules
migbash_modules_path='./modules/'

# MigBash initialization
init() {
    module=$1
    method=$2
    params=${@:3}
    if [ ! -f ${migbash_cfg} ]
    then
        echo 'Config file not found...'
        exit 0
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
        for MODULE in $(ls ${migbash_modules_path}${module})
        do
            . ${migbash_modules_path}${module}/${MODULE}
        done
        ${method} ${params}
    fi
    exit 1
}

# run init
init $*
