MODULE := mkat
SRC := src

build: src
	dpkg-buildpackage -rfakeroot -I'*.swp' -iCVS
	lintian -i ../$(MODULE)*deb

up: build
	debrelease --dput -f local

src:
	-cvs co -d $(SRC) mkat

clean:
	fakeroot debian/rules clean

.PHONY: build src clean
