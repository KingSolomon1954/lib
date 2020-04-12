

# See https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences

# See git clone --depth=1 https://github.com/Bash-it/bash-it.git
# then bash-it/themes/colors.theme.bash

function __color_rgb {
  r=$1 && g=$2 && b=$3
  [[ r == g && g == b ]] && echo $(( $r / 11 + 232 )) && return # gray range above 232
  echo "8;5;$(( ($r * 36  + $b * 6 + $g) / 51 + 16 ))"
}

