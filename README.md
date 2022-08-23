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
