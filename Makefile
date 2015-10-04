SCRIPT = bash_utils.sh
BIN ?= BashUtils
PREFIX ?= $(HOME)

install:
	cp $(SCRIPT) $(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
