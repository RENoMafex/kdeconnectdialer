INSTALLDIR=/usr/bin/dial

$(INSTALLDIR): call.sh
	sudo cp -v dial.sh $(INSTALLDIR)
