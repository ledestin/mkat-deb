MODULE := mkat
SRC := src

PACKAGE = dpkg-buildpackage -rfakeroot -I'*.swp' -i.svn
CHECK := lintian -i ../$(MODULE)*deb

#package, but don't sign (good for everyday life)
build: src
	$(PACKAGE) -us -uc
	$(CHECK)

#package and sign (for Debian)
debuild: src
	$(PACKAGE)
	$(CHECK)

up: build
	debrelease --dput -f local

src:
	-cvs co -d $(SRC) mkat
	-cd $(SRC) && cvs2cl -t -R '^[^#]+$$' -f changelog

clean:
	fakeroot debian/rules clean

.PHONY: build debuild up src clean
