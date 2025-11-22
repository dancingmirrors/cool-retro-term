TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += qmltermwidget
SUBDIRS += app

# PREFIX support
# Read PREFIX from environment, but don't set a default here
# The default is provided by .prefix_default.mk included in the Makefile
isEmpty(PREFIX):PREFIX = $$(PREFIX)

# Use $(PREFIX) in Makefile to allow override via make PREFIX=...
LITERAL_DOLLAR = $$escape_expand(\\$)

# Generate .mk files with PREFIX default in both root and app directories
# Use /usr as the default value in the .mk files
system(echo \"PREFIX ?= /usr\" > .prefix_default.mk)
system(mkdir -p app && echo \"PREFIX ?= /usr\" > app/.prefix_default.mk)
QMAKE_DISTCLEAN += .prefix_default.mk

desktop.files = cool-retro-term.desktop
desktop.path = /$${LITERAL_DOLLAR}(PREFIX)/share/applications

INSTALLS += desktop
