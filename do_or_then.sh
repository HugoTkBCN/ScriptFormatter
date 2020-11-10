#!/bin/bash
##
## EPITECH PROJECT, 2020
## script_formatter
## File description:
## search if there is do or then in a line
##


do_or_then() {

    if [[ ${1:0:4} = "then" ]]; then
        if [[ ${option[-e]} == 1 ]]; then
            echo
            make_indentation
            printf "then"
        else
            if [[ $2 == 0 ]]; then
                printf ";"
            fi
            printf " then"
        fi
        ((indent_level++))
        return 4
    elif [[ ${1:0:2} = "do" ]]; then
        if [[ ${option[-e]} == 1 ]]; then
            echo
            make_indentation
            printf "do"
        else
            if [[ $2 == 0 ]]; then
                printf ";"
            fi
            printf " do"
        fi
        ((indent_level++))
        return 2
    else
        return 0
    fi
}

done_or_fi() {

    if [[ ${1:0:4} = "done" ]]; then
        ((indent_level--))
        make_indentation
        printf "done"
        return 4
    elif [[ ${1:0:2} = "fi" ]]; then
        ((indent_level--))
        make_indentation
        printf "fi"
        return 2
    else
        return 0
    fi
}

else_or_elif() {

    if [[ ${1:0:4} = "else" ]]; then
        ((indent_level--))
        make_indentation
        printf "else"
        ((indent_level++))
        return 4
    elif [[ ${1:0:4} = "elif" ]]; then
        ((indent_level--))
        make_indentation
        printf "elif"
        ((indent_level++))
        return 4
    else
        return 0
    fi
}