#!/usr/bin/env bash

# MigBash is the script that implements simple migrations for your database

# MigBash config file
migbash_cfg='migbash.cfg'

# path to folder with modules
migbash_modules_path='./modules/'

# MigBash initialization
init() {
    get_module=$1
    get_method=$2
    params=${@:3}
    if [ ! -f ${migbash_cfg} ]
    then
        echo 'Config file not found...'
        exit 0
    fi

    if [ ! -f ${migbash_modules_path}${get_module} ]
    then
        echo -en 'Module not found...\r\n'
    else
        . ${migbash_modules_path}${get_module}
        ${get_method} ${params}
    fi
}

# run init
init $*
#foo
#if [[ ${module} == "" ]]
#then
#    "${method}"
#else
#    echo ${module}
#fi

#foo
