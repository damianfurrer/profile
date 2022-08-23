#!/bin/bash
tomap=$(grep -v "^#" deb.tomap)
declare -i i
while [ 1 -eq 1 ]
do
  line=$(sed 1q <<< "${tomap}")
  tomap=$(awk 'NR>1 {print}'  <<< "${tomap}")
  [ "$line" == "" ] && continue
  pkgname=$(awk '{print $1}' FS='@' <<< "${line}")
  grpn=$(sed 's/*/./' <<< "${pkgname}")
  echo "$grpn"
  clear
  echo "Selection for ${pkgname}: "
  selection=$(grep "${grpn}" pkg.multiple)
  i=1
  while read line
  do
    echo "$i.)${line}"
    i+=1
  done <<< "${selection}"
  read -p "Entern nr.: " lnnr
  selected=$(awk "NR==$lnnr"' {print}' <<< "${selection}")
  [ "${selected}" == "" ] && continue
  echo "${pkgname};${selected}" >> pkg.translate
  [ "$tomap" == "" ] && break
#exit

done  #<<< $(tail -n -1 deb.tomap)

echo "run searchdeb.sh & make manually to update"
