package.provided: package.provided.bak package.provided.dirty package.provided.nondirty pkg.generalassumed
	cat /etc/portage/profile/package.provided.dirty /etc/portage/profile/package.provided.nondirty /etc/portage/profile/pkg.generalassumed > /etc/portage/profile/package.provided

package.provided.bak: package.provided.tst
	[ ! -e "/etc/portage/profile/package.provided" ] || mv /etc/portage/profile/package.provided /etc/portage/profile/package.provided.bak

package.provided.dirty: package.provided.tst
	sh /etc/portage/profile/dirtycleanatom.sh
package.provided.nondirty:
	echo "" > /etc/portage/profile/package.provided.nondirty
package.provided.tst: deb.provided
	bash /etc/portage/profile/searchdeb.sh

pkg.generalassumed:
	echo "#unhandled/basic assumptions(e.g. satisfied by a basic debian install)" > /etc/portage/profile/pkg.generalassumed

deb.provided:
	bash /etc/portage/profile/getdpkgs.sh

.PHONY: clean clean-all package.provided.bak
clean:
	-rm deb.notfound deb.tomap package.provided.tst pkg.multiple package.provided.dirty package.provided.nondirty package.provided.bak

clean-all: clean
	-rm deb.provided pkg.translate deb.translate pkg.generalassumed

regen: clean-all package.provided.tst

