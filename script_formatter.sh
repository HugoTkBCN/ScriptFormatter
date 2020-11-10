#!/bin/bash
##
## EPITECH PROJECT, 2020
## shell_formatter
## File description:
## formatting file
##

print_help() {
  echo -e $"Usage:  script_formatter.sh in [-h] [-s] [-i nb_char] [-e] [-o out]

        in                       input file
      -h, --header              header generation
      -s, --spaces              force spaces instead of tabulations for indentation
      -i, --indentation=nb_char number of characters for indentation (8 by default)
      -e, --expand              force \e[3mdo\e[0m and \e[3mthen\e[0m keywords on new lines
      -o, --output=out          output file (\e[3mstdout\e[0m by default)"
      exit 0
}

main() {
  . error_handling.sh
  main_error_handling $@
  . do_or_then.sh
  . header.sh
  . indentation_formatter.sh
  . print_code.sh
  . output_modification.sh
  . shebang_detection.sh
  output_modification
  shebang_formatter $filename
  if [[ ${option[-h]} == 1 ]]; then
    echo
    create_header $filename
  fi
  print_code $filename
}
declare -A option
option[-h]=0
option[-s]=0
option[-i]=0
option[-e]=0
option[-o]=0
filename=0
indent_level=0
main $@