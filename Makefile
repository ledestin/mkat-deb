MODULE := mkat
VERSION := 0.5
DEB := ../$(MODULE)_$(VERSION)*.deb
SRC := https://github.com/ledestin/mkat.git

PACKAGE = dpkg-buildpackage -rfakeroot -I'*.swp' -i.git
CHECK := lintian -i ../$(MODULE)*deb

#package, but don't sign (good for everyday life)
build: src
	$(PACKAGE) -us -uc
	$(CHECK)

#package and sign (for Debian)
debuild: src
	$(PACKAGE)
	$(CHECK)

sign:
	gpg -b $(DEB)

src:
	git clone $(SRC) src
	cd src && make changelog

clean:
	rm -rf src
	fakeroot debian/rules clean

upload_savannah:
	scp $(DEB) $(DEB).sig ledestin@dl.sv.gnu.org:/releases/mkat/

.PHONY: build clean debuild sign upload_savannah
