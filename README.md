# profile
dpkgtopkgprovided - /etc/portage
directory profile belongs into /etc/portage

# Useing it

`make` will fail the first time
do your mappings or call `make` again.


`make clean` deletes tmp files
`make clean-all` deletes all generated files


# Scripts

getdpkgs.sh:       queries installed packages & writes them to deb.provided

searchdeb.sh:      writes translateable packages to package.provided.tst

map.sh:            manually map package names with multiple possible translations (adds to pkg.translate)

dirtycleanatom.sh: cleans package.provided.tst versions from debian patch versions etc. (we hope these don't break compatibility with the underlying version) writes package.provided.dirty


# Files

deb.provided - list of installed debian packages

pkg.translate - deb pkg name to gentoo category/packagename translation

deb.translate - deb pkg name & version fixed translation

package.provided - final result

pkg.generalassumed - empty, define unmapped base assumptions here (e.g. gnuconfig)

## Tmp Files

pkg.multiple - found options per pkgname

package.provided.nondirty - result of the deb.translate fixed mapping

package.provided.tst - list of packages with assumed corresponding category

package.provided.dirty - list with a valid version


# Translation
## my versions
deb.translate:
https://gist.github.com/damianfurrer/2f661e0adca9e1faa5814195945107a5/raw/a466de16f4c66145fe6bfc685e7ebc0cb58abd4e/deb.translate.bak

pkg.translate:
https://gist.github.com/damianfurrer/6af2f646476ba2a75b57ae0097db8a23/raw/0d9be1d7b929aa1d69d54bfc8104f513c9327c6b/pkg.translate.bak

pkg.generalassumed:
https://gist.github.com/damianfurrer/5c8cef02867c45ea9a0fe76386a06443/raw/e5d5f24c51e2a9c9a0f70b5f0b27795742b38c35/pkg.generalassumed
