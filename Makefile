INSTALLDIR=/usr/bin/call

$(INSTALLDIR): call.sh
	sudo cp -v call.sh $(INSTALLDIR)
