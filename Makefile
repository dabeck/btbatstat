MAKEFLAGS     = --no-print-directory --no-builtin-rules
.DEFAULT_GOAL = all

# Variables
PACKAGE = BtBatStat

# If `venv/bin/python` exists, it is used. If not, use PATH to find python.
SYSTEM_PYTHON  = $(or $(shell which python3), $(shell which python))
PYTHON         = $(or $(wildcard venv/bin/python3), $(SYSTEM_PYTHON))

BUILDARCH?=$(shell uname -m)
# unless otherwise set, I am building for my own architecture, i.e. not cross-compiling
ARCH ?= $(BUILDARCH)

all: clean venv deps build

.PHONY: all venv deps setup build clean install

venv:
		rm -rf venv
		$(SYSTEM_PYTHON) -m venv venv

deps:
		$(PYTHON) -m pip install -r requirements.txt

setup:
		./setup.sh

build: setup
		$(PYTHON) setup.py py2app --arch $(ARCH)

clean:
		rm -rf venv
		rm -rf build
		rm -rf dist
		rm -rf setup.py

install:
		cp -r ./dist/$(PACKAGE).app /Applications/