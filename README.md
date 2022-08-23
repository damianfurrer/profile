# profile
dpkgtopkgprovided - /etc/portage
directory profile belongs into /etc/portage

#Useing it

'''make'''



#Scripts

getdpkgs.sh:       queries installed packages & writes them to deb.provided

searchdeb.sh:      writes translateable packages to package.provided.tst

map.sh:            manually map package names with multiple possible translations (adds to pkg.translate)

dirtycleanatom.sh: cleans package.provided.tst versions from debian patch versions etc. (we hope these don't break compatibility with the underlying version) writes package.provided.dirty


#Files
deb.provided - list of installed debian packages

pkg.translate - deb pkg name to gentoo category/packagename translation

package.provided.tst - list of packages with assumed corresponding category

package.provided.dirty - list with a valid version


