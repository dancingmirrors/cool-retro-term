TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += qmltermwidget
SUBDIRS += app

# PREFIX support
isEmpty(PREFIX) {
    PREFIX = /usr
}

desktop.files += cool-retro-term.desktop
desktop.path += $$PREFIX/share/applications

INSTALLS += desktop
