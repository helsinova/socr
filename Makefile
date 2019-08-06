SHELL := /bin/bash
MAKEPWD := $(shell pwd)
ifeq (${MAKELEVEL},0)

%:
	-source ${MAKEPWD}/.env && $(MAKE) $(MFLAGS) -e -C . $@

else

.PHONY: \
    install \
    uninstall

CURRENT_DIR := $(shell pwd)
PROJECT ?= $(shell basename `pwd`)
VERSION ?= UNKNOWN
INSTALL_DIR_BASE ?= /usr/local
INSTALL_DIR_BIN  ?= ${INSTALL_DIR_BASE}/bin
INSTALL_DIR_LIB  ?= ${INSTALL_DIR_BASE}/lib/${PROJECT}
INSTALL_DIR_MAN  ?= ${INSTALL_DIR_BASE}/share/man

BIN_SCRIPTS_SRC_DIR  := bin
BIN_SCRIPTS          :=
BIN_SCRIPTS          += socr.sh
BIN_SCRIPTS_NOSFX    := $(patsubst %.sh, %, ${BIN_SCRIPTS})
BIN_SCRIPTS_SRC      := $(patsubst %, ${BIN_SCRIPTS_SRC_DIR}/%, ${BIN_SCRIPTS})
BIN_SCRIPTS_DST      := $(patsubst %, ${INSTALL_DIR_BIN}/%, ${BIN_SCRIPTS_NOSFX})

LIB_SCRIPTS_SRC_DIR  := lib
LIB_SCRIPTS          :=
LIB_SCRIPTS_CMDS     := $(patsubst lib/%, % , $(shell ls ${LIB_SCRIPTS_SRC_DIR}/TBD-*.sh))
LIB_SCRIPTS          += ${LIB_SCRIPTS_CMDS}
LIB_SCRIPTS_NOSFX    := $(patsubst %.sh, %, ${LIB_SCRIPTS})
LIB_SCRIPTS_SRC      := $(patsubst %, ${LIB_SCRIPTS_SRC_DIR}/%, ${LIB_SCRIPTS})
LIB_SCRIPTS_DST      := $(patsubst %, ${INSTALL_DIR_LIB}/%, ${LIB_SCRIPTS_NOSFX})

${INSTALL_DIR_BIN}/%: ${BIN_SCRIPTS_SRC_DIR}/%.sh
	sudo cp $(patsubst ${INSTALL_DIR_BIN}/%, ${BIN_SCRIPTS_SRC_DIR}/%.sh, $@) $@

${INSTALL_DIR_LIB}/%: ${INSTALL_DIR_LIB} ${LIB_SCRIPTS_SRC_DIR}/%.sh
	sudo cp $(patsubst ${INSTALL_DIR_LIB}/%, ${LIB_SCRIPTS_SRC_DIR}/%.sh, $@) $@

${INSTALL_DIR_LIB}:
	sudo mkdir $@

install: ${LIB_SCRIPTS_DST} ${BIN_SCRIPTS_DST}
	@echo "[${PROJECT}] is installed"

uninstall:
	sudo rm ${BIN_SCRIPTS_DST}
	sudo rm ${LIB_SCRIPTS_DST}
	@echo "[${PROJECT}] is un-installed"


split_line_print = awk '{for (i=1;i<=NF;i++){print "  "$$i;}}'

info:
	@echo
	@echo "PROJECT/VERSION:"
	@echo ${PROJECT}/${VERSION}
	@echo
	@echo "BIN_SCRIPTS:"
	@echo ${BIN_SCRIPTS}          | $(split_line_print)
	@echo
	@echo "BIN_SCRIPTS_NOSFX"
	@echo ${BIN_SCRIPTS_NOSFX}    | $(split_line_print)
	@echo
	@echo "BIN_SCRIPTS_SRC:"
	@echo ${BIN_SCRIPTS_SRC}      | $(split_line_print)
	@echo
	@echo "BIN_SCRIPTS_DST:"
	@echo ${BIN_SCRIPTS_DST}      | $(split_line_print)
	@echo
	@echo "LIB_SCRIPTS:"
	@echo ${LIB_SCRIPTS}          | $(split_line_print)
	@echo
	@echo "LIB_SCRIPTS_CMDS:"
	@echo ${LIB_SCRIPTS_CMDS}     | $(split_line_print)
	@echo
	@echo "LIB_SCRIPTS_NOSFX"
	@echo ${LIB_SCRIPTS_NOSFX}    | $(split_line_print)
	@echo
	@echo "LIB_SCRIPTS_SRC:"
	@echo ${LIB_SCRIPTS_SRC}      | $(split_line_print)
	@echo
	@echo "LIB_SCRIPTS_DST:"
	@echo ${LIB_SCRIPTS_DST}      | $(split_line_print)
	@echo
	@echo

endif #MAKELEVEL
