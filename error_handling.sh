#!/bin/bash
##
## EPITECH PROJECT, 2020
## script_formatter
## File description:
## error handling
##

error() {
    echo -e $"Error: $*\nRun ./script_formatter -help" >>/dev/stderr
    exit 84
}


check_nbr_arg() {
    if (( $# < 1 )) || (( $# > 8 )); then
        error "Invalid number of arguments."
    fi
}

check_first_arg() {
    if [[ $# -gt 1 ]] && [[ $1 == "-help" ]]; then
        error "Too many arguments."
    elif [ $1 == "-help" ]; then
        print_help
    elif ! [[ -f $1 ]]; then
        error "File $1 doesn't exist."
    fi
}

simple_dash_multiple_letter() {
    flag=${flag:1}
    for ((index = 0; index < ${#flag}; index++))
    do
        if [[ ${option[-${flag:$index:1}]} == 0 ]]; then
            case ${flag:$index:1} in
                i)  [[ $i_change == 1 ]] && error "Option -${flag:$index:1} use more than once."
                    [[ ${arguments[$next_arg]} =~ ^[0-9]{1,} ]] && option[-${flag:$index:1}]=${arguments[$next_arg]} || error "Bad arguments for -$flag"
                    ((next_arg++))
                    i_change=1
                    ;;
                o) [[ ${arguments[$next_arg]} =~ ^.{1,} ]] && option[-${flag:$index:1}]=${arguments[$next_arg]} || error "Bad arguments for -$flag"
                    ((next_arg++))
                    ;;
                *)  option[-${flag:$index:1}]='1'
                    ;;
            esac
        else
            error "Option -${flag:$index:1} use more than once."
        fi
    done 
}

get_simple_dash() {
    next_arg=nbr_arg
    if (( ${#flag} > 2 )); then
        simple_dash_multiple_letter
    elif [[ ${option[$flag]} == 0 ]]; then
        case $flag in
            -i) [[ $i_change == 1 ]] && error "Option $flag use more than once."
                i_change=1
                [[ ${arguments[$nbr_arg]} =~ ^[0-9]{1,}$ ]] && option[$flag]=${arguments[$nbr_arg]} || error "Bad arguments for $flag"
                return 1
                ;;
            -o) [[ ${arguments[$nbr_arg]} =~ ^.{1,} ]] && option[$flag]=${arguments[$nbr_arg]} || error "Bad arguments for $flag"
                return 1
                ;;
            *)  option[$flag]='1'
                ;;
        esac
    else
        error "Option $flag use more than once."
    fi
    ret=0
    let "ret=next_arg-nbr_arg"
    return $ret
}

get_double_dash() {
    case $flag in
        --header) [[ ${option[-h]} == 0 ]] && option[-h]=1 || error "Option $flag use more than once."
            ;;
        --spaces) [[ ${option[-s]} == 0 ]] && option[-s]=1 || error "Option $flag use more than once."
            ;;
        --expand) [[ ${option[-e]} == 0 ]] && option[-e]=1 || error "Option $flag use more than once."
            ;;
    esac
}

get_args(){
    if [[ "$flag" =~ ^[-][h|s|i|e|o]{1,}$ ]]; then
        get_simple_dash
        return $(echo $?)
    elif [[ "$flag" =~ ^[-]{2}("header"|"spaces"|"expand")$ ]]; then
        get_double_dash
    elif [[ "$flag" =~ ^[-]{2}("indentation="[0-9]{1,}$) ]];then
        [[ $i_change == 0 ]] && option[-i]=${flag//--indentation=} || error "Option --indentation use more than once."
        i_change=1
    elif [[ "$flag" =~ ^[-]{2}("output=".{1,}) ]];then
        [[ ${option[-o]} == 0 ]] && option[-o]=${flag//--output=} || error "Option --output use more than once."
    else
        error
    fi
    return 0
}

check_flags() {
    arguments=($@)
    nbr_arg=0
    swipe=0
    for flag in $@
    do
        ((nbr_arg++))
        if [[ $nbr_arg == 1 ]]; then
            filename=$flag
        elif ! [[ $swipe == 0 ]]; then
            ((swipe--))
        else
            if ! [[ "$flag" =~ ^[-][h|s|i|e|o]{1,}$ ]] \
            && ! [[ "$flag" =~ ^[-]{2}("header"|"spaces"|"expand")$ ]] \
            && ! [[ "$flag" =~ ^[-]{2}("indentation="[0-9]{1,}$|"output=".{1,}) ]]; then
                error "Bad argument : $flag"
            else
                get_args
                swipe=$(echo $?)
            fi
        fi
    done
    [[ ${option[-o]} == 0 ]] && option[-o]='/dev/stdout'
    [[ $i_change == 0 ]] && option[-i]=8
}

main_error_handling() {
    i_change=0
    check_nbr_arg $@
    check_first_arg $@
    check_flags $@
}