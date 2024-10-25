

# See https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences

# See git clone --depth=1 https://github.com/Bash-it/bash-it.git
# then bash-it/themes/colors.theme.bash

function __color_rgb {
  r=$1 && g=$2 && b=$3
  [[ r == g && g == b ]] && echo $(( $r / 11 + 232 )) && return # gray range above 232
  echo "8;5;$(( ($r * 36  + $b * 6 + $g) / 51 + 16 ))"
}

# Shared bash file for color variables.
# Used with various resource help scripts.
#
# Had to figure out weird behavior where the color variables were not
# being evaulated. Tried a good number of variations. Wound up escaping
# the escape character three times to get this to work together with a
# here document.
#
# Note that this escape sequence doesn't agree with shell documentation,
# but then this is being invoked through makefile, then shell script,
# then inside a here document. Be aware that sourcing this for regular
# bash scripts won't work as there will be too many escapes.

ESC="\033"
FG="${ESC}[38;5;"
BG="${ESC}[48;5;"

FG_BLACK="${FG}30m"
FG_RED="${FG}31m"
FG_GREEN="${FG}32m"
FG_YELLOW="${FG}33m"
FG_BLUE="${FG}34m"
FG_MAGENTA="${FG}35m"
FG_CYAN="${FG}36m"
FG_WHITE="${FG}37m"

BG_BLACK="${BG}30m"
BG_RED="${BG}31m"
BG_GREEN="${BG}32m"
BG_YELLOW="${BG}33m"
BG_BLUE="${BG}34m"
BG_MAGENTA="${BG}35m"
BG_CYAN="${BG}36m"
BG_WHITE="${BG}37m"

CLEAR="${ESC}[0m"
BRIGHT="${ESC}[1m"
DIM="${ESC}[2m"
UNDERLINE="${ESC}[4m"
BLINK="${ESC}[5m"
REVERSE="${ESC}[7m"
HIDDEN="${ESC}[8m"

