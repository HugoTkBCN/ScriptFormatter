#!/bin/bash
##
## EPITECH PROJECT, 2020
## shell_formatter
## File description:
## header creation
##

set_date_month() {

    MONTH=`date -r $1 +"%m"`
    months='January February March April May June July August September October November December'
    count=1

    for word in $months
    do
        if [[ $count = ${MONTH:1:1} ]] && [[ ${MONTH:0:1} = 0 ]]; then
           printf "%s, " $word
        elif [[ $count = $MONTH ]]; then
            printf "%s, " $word
        fi
        let "count += 1"
    done
}

set_date_day() {

    DAY=`date -r $1 +"%d"`
    YEAR=`date -r $1 +"%Y"`

    if [[ ${DAY:0:1} = 0 ]] && [[ ${DAY:1:1} != 1 ]] && [[ ${DAY:1:1} != 2 ]] && [[ ${DAY:1:1} != 3 ]]; then
        printf "#♥ %cth " ${DAY:1:1}
    elif [[ ${DAY:0:1} = 0 ]] && [[ ${DAY:1:1} = 1 ]]; then
        printf  "#♥ %cst " ${DAY:1:1}
    elif [[ ${DAY:0:1} = 0 ]] && [[ ${DAY:1:1} = 2 ]]; then
        printf "#♥ %cnd " ${DAY:1:1}
    elif [[ ${DAY:0:1} = 0 ]] && [[ ${DAY:1:1} = 3 ]]; then
        printf "#♥ %cd " ${DAY:1:1}
    else
        printf "#♥ %sth " $DAY
    fi
    set_date_month $1
    echo $YEAR
    echo '#'
    echo '#♥'
    echo '#'
}

create_header() {

    count=0
    num=0

    echo "#♥    ♥    ♥    ♥    ♥    ♥  "
    echo "#   ♥    ♥    ♥    ♥    ♥    ♥"
    echo "#♥ "$1
    echo '#'
    set_date_day $1
    while read line;
    do
        if [[ ${line:0:1} != '#' ]]; then
            let "count = 1"
        fi
        if [[ $num != 0 ]] && [[ $count != 1 ]]; then
            if [[ ${line:0:1} = '#' ]]; then
                echo "#♥" ${line:1}
                echo '#'
            fi
        fi
        let "num += 1"
    done < $1
    echo "#♥    ♥    ♥    ♥    ♥    ♥  "
    echo "#   ♥    ♥    ♥    ♥    ♥    ♥"
}
