#/bin/bash
exactlyoneatom(){
list=$(cat -)
len=$(grep -c "" <<< "${list}")
#return 1
if [ "$len" -le "1" ]; then
  [ "$list" == "" ] && echo "*/" && return 1
  [ "$len" -eq "1" ] && echo "${list}" # && return 0
else
  echo "*/"
  echo "" >>/etc/portage/profile/pkg.multiple
  echo "${list}" >>/etc/portage/profile/pkg.multiple
  echo "" >>/etc/portage/profile/pkg.multiple
  return 2
 # select
fi
#return 1
}

translateatom(){
[ -e "/etc/portage/profile/pkg.translate" ] || return 0
translation=$(grep -m 1 -F "${1}" /etc/portage/profile/pkg.translate)
[ "$translation" != "" ] || return 0
awk '{print $2}' FS=';' <<< "${translation}"
return 1

}

searchpkg(){
atom=$(cat -)
#find /var/db/repos/gentoo/ $atom -maxdepth 0 | grep -v -F "/var/db/repos/gentoo"
translateatom "${atom}" || return 0
find /var/db/repos/gentoo/ -mindepth 2 -maxdepth 2 -type d -path "${atom}" | grep -v "/var/db/repos/gentoo/virtual/" | grep -v "/var/db/repos/gentoo/acct-group/" | grep -v "/var/db/repos/gentoo/acct-user/" | sed 's/\/var\/db\/repos\/gentoo\///' | exactlyoneatom
#return 1
return $?
}

translatedebversion(){
  [ -e "/etc/portage/profile/deb.translate" ] && grep -m 1 -F "${1};" deb.translate | awk '{print $2}' FS=';'
}

(echo -n "#"; date +%Y-%m-%d) > /etc/portage/profile/package.provided.tst
echo "#multiple categories have a fitting package, simple translation needed" > /etc/portage/profile/pkg.multiple
echo "#no package found, manual translation needed" > /etc/portage/profile/deb.notfound
echo "#theses have multiple fitting packages(does not have to be one of them)" > /etc/portage/profile/deb.tomap


while read line
do
  atom=""
  atom=$(translatedebversion "${line}")
  [ "$atom" != "" ] && echo "${atom}" >> /etc/portage/profile/package.provided.nondirty
  [ "$atom" != "" ] && continue
  #vers=$(awk '{print $2}' FS='@' <<< "${line}")
  vers="9999"
  atom=$(awk '{print $1}' FS='@' <<< "${line}" | searchpkg)
  code=$?
  [ "$code" -eq "0" ] && echo "${atom}-${vers}" >> /etc/portage/profile/package.provided.tst
  [ "$code" -eq "1" ] && echo "No Atom found:           ${line}" >&2 && echo "${line}" >> /etc/portage/profile/deb.notfound
  [ "$code" -eq "2" ] && echo "Multiple Atoms possible: ${line}" >&2 && echo "${line}" >> /etc/portage/profile/deb.tomap
  #searchpkg <<< "${atom}" #&& echo "${atom}-${vers}" >> /etc/portage/profile/package.provided.tst
  #echo "$?"
#exit
done <<<$(grep -v "^#" deb.provided)
