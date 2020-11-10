#!/bin/bash
##
## EPITECH PROJECT, 2020
## shell_formatter
## File description:
## function to manage indentation
##

if [[ ${option[-s]} == 0 ]]; then
    indent_character="\t"
else
    indent_character=" "
fi
make_indentation() {
    indentation=""
    for (( k=0; k<$indent_level; k++ )); do
        for (( j=0; j<${option[-i]}; j++ )); do
            indentation=$indent_character$indentation
        done
    done
    printf "$indentation"
}

print_curly() {
    if [ $1 == '{' ]; then
        echo ''
        make_indentation
        echo $1
        ((indent_level++))
        make_indentation
    elif [ $1 == '}' ]; then
        ((indent_level--))
        echo ''
        make_indentation
        echo $1
        make_indentation
    fi
}