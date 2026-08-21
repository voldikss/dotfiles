PACKAGES ?=
SYSTEM_PACKAGES ?=

.PHONY: help list list-system home system

help:
	@echo "Usage:"
	@echo "  make list                         # list home packages"
	@echo "  make list-system                  # list system packages"
	@echo "  make home PACKAGES='zsh git nvim' # install selected home packages"
	@echo "  make home                         # install all home packages"
	@echo "  make system SYSTEM_PACKAGES='pacman docker'"

list:
	./install.sh -l

list-system:
	./install.sh -s -l

home:
	@if [ -z "$(PACKAGES)" ]; then ./install.sh -a; else ./install.sh $(PACKAGES); fi

system:
	@if [ -z "$(SYSTEM_PACKAGES)" ]; then sudo ./install.sh -s -a; else sudo ./install.sh -s $(SYSTEM_PACKAGES); fi
