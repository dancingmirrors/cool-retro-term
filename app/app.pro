QT += qml quick widgets sql quickcontrols2
TARGET = cool-retro-term 

DESTDIR = $$OUT_PWD/../

HEADERS += \
    fileio.h \
    monospacefontmanager.h \
    wallpaperdetector.h

SOURCES = main.cpp \
    fileio.cpp \
    monospacefontmanager.cpp \
    wallpaperdetector.cpp

macx:ICON = icons/crt.icns

RESOURCES += qml/resources.qrc

#########################################
##              INTALLS
#########################################

# PREFIX support
# Read PREFIX from environment, but don't set a default here
# The default is provided by .prefix_default.mk included in the Makefile
isEmpty(PREFIX):PREFIX = $$(PREFIX)

# Use $(PREFIX) in Makefile to allow override via make PREFIX=...
LITERAL_DOLLAR = $$escape_expand(\\$)

# Generate a .mk file with PREFIX default
# Use /usr as the default value in the .mk file
system(echo \"PREFIX ?= /usr\" > .prefix_default.mk && echo \".prefix_default.mk created\")
QMAKE_DISTCLEAN += .prefix_default.mk

target.path = /$${LITERAL_DOLLAR}(PREFIX)/bin

INSTALLS += target

# Install icons
unix {
    icon32.files = icons/32x32/cool-retro-term.png
    icon32.path = /$${LITERAL_DOLLAR}(PREFIX)/share/icons/hicolor/32x32/apps
    icon64.files = icons/64x64/cool-retro-term.png
    icon64.path = /$${LITERAL_DOLLAR}(PREFIX)/share/icons/hicolor/64x64/apps
    icon128.files = icons/128x128/cool-retro-term.png
    icon128.path = /$${LITERAL_DOLLAR}(PREFIX)/share/icons/hicolor/128x128/apps
    icon256.files = icons/256x256/cool-retro-term.png
    icon256.path = /$${LITERAL_DOLLAR}(PREFIX)/share/icons/hicolor/256x256/apps
    iconScalable.files = icons/hicolor/scalable/apps/cool-retro-term.svg
    iconScalable.path = /$${LITERAL_DOLLAR}(PREFIX)/share/icons/hicolor/scalable/apps
    iconSymbolic.files = icons/hicolor/symbolic/apps/cool-retro-term-symbolic.svg
    iconSymbolic.path = /$${LITERAL_DOLLAR}(PREFIX)/share/icons/hicolor/symbolic/apps

    INSTALLS += icon32 icon64 icon128 icon256 iconScalable iconSymbolic
}
