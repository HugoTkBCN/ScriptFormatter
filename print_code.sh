#!/bin/bash
##
## EPITECH PROJECT, 2020
## shell_formatter
## File description:
## print everything except shebang and header
##

print_code_line() {
    do_or_then ${line:0} 0
    start=$?
    if [[ $start == 0 ]]; then
       echo 
    fi
    line=$*
    for ((i = $start; i < ${#line}; i++))
    do
        if [[ ${line:$i:1} == '{' ]] || [[ ${line:$i:1} == '}' ]]; then
            print_curly ${line:$i:1}
        else
            do_or_then ${line:$i} $i
            dot=$?
            if [[ $dot == 0 ]]; then
                done_or_fi ${line:$i}
                dof=$?
                if [[ $dof == 0 ]]; then
                    else_or_elif ${line:$i}
                    eoe=$?
                    if [[ $eoe != 0 ]]; then
                        ((i+=eoe))
                    else
                        if [[ $i == 0 ]]; then
                            make_indentation
                        fi
                        printf "${line:$i:1}"
                    fi
                else
                    ((i+=dof))
                fi
            else
                ((i+=dot))
            fi
        fi
    done
}

print_code() {
    is_code=0
    while read line || [[ -n "$line" ]];
    do
        if [[ ${line:0:2} != "#!" ]]; then
            if [[ ${line:0:1} == "#" ]] && [[ $is_code == 0 ]] && [[ ${option[-h]} == 0 ]]; then
                print_code_line $line
            elif [[ ${line:0:1} != "#" ]] || [[ $is_code == 1 ]]; then
                print_code_line $line
                is_code=1
            fi
        fi
    done < $1
    echo
}