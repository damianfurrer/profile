#!/bin/sh

sed 's/+.*$//' package.provided.tst > package.provided.dirty

#[ -e "package.provided.dirty" ] && rm  package.provided.dirty
#while read line
#do
#  grep -c -F ";${line}" deb.translate
#done < package.provided.tst
