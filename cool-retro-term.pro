TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += qmltermwidget
SUBDIRS += app

# PREFIX support
isEmpty(PREFIX):PREFIX = $$(PREFIX)
isEmpty(PREFIX) {
    PREFIX = /usr
}

# Use $(PREFIX) in Makefile to allow override via make PREFIX=...
LITERAL_DOLLAR = $$escape_expand(\\$)

# Generate a .mk file with PREFIX default in the build directory
system(echo \"PREFIX ?= $$PREFIX\" > .prefix_default.mk)
QMAKE_DISTCLEAN += .prefix_default.mk

desktop.files = cool-retro-term.desktop
desktop.path = /$${LITERAL_DOLLAR}(PREFIX)/share/applications

INSTALLS += desktop
