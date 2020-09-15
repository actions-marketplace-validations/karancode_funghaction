#!/bin/bash

fun_type_all=(fact joke quote)

function random_choice {

    len=${#fun_type_all[@]}
    random_index=$(($RANDOM % $len))
    fun_type=${fun_type_all[$random_index]}
    echo $fun_type
}

function contains {
    list="${1}"
    key="${2}"
    for word in ${list}
    do
        if [ "${word}" == "${key}" ]; then
            return 1
        fi
    done
    return 0
}

function parse_input {

    fun_type="random"
    if [ "${INPUT_FUN}" != "" ]; then
        contains "${fun_type_all[*]}" "${INPUT_FUN}"
        if [ "${?}" == 1 ]; then
            echo "setting fun type to '${INPUT_FUN}'."
            fun_type="${INPUT_FUN}"
        else
            echo "invalid fun type string '${INPUT_FUN}'. Must be one of [random, gif, joke, quote]. Defaulting to 'random'."
        fi
    fi
}

function main {
    
    scriptDir=$(dirname ${0})
    source ${scriptDir}/fun.sh
    parse_input
    
    if [ "${fun_type}" == "random" ]; then
        random_choice
    fi

    echo $fun_type

    case $fun_type in

    fact)
        get_fact
        ;;
    joke)
        get_joke
        ;;
    quote)
        get_quote
        ;;
    esac
}

main "${*}"