# PREFIX Installation Support

This project now supports customizable installation paths via the PREFIX variable.

## Quick Start

There are two ways to specify a custom PREFIX:

### Option 1: Set PREFIX during qmake (Recommended)

```bash
PREFIX=/usr/local qmake
make
sudo make install
```

### Option 2: Set PREFIX during make install

```bash
qmake
make
bash fix-makefiles.sh  # Run this script once after qmake
sudo make PREFIX=/usr/local install
```

## Details

- **Default PREFIX**: `/usr`  
  Files install to `/usr/bin`, `/usr/share/applications`, etc.

- **Custom PREFIX**: Set to any path like `/usr/local`, `/opt/cool-retro-term`, etc.
  
- **Option 1 (Environment Variable)**: Cleaner, sets PREFIX at configuration time
  
- **Option 2 (Make Variable)**: More flexible, allows changing PREFIX without re-running qmake,  
  but requires running `fix-makefiles.sh` once after `qmake`

## Examples

Install to `/usr/local`:
```bash
PREFIX=/usr/local qmake && make && sudo make install
```

Install to `/opt`:
```bash
qmake && make && bash fix-makefiles.sh && sudo make PREFIX=/opt install
```

Install to a staging directory (for packaging):
```bash
PREFIX=/usr qmake && make && make install INSTALL_ROOT=/tmp/staging
```

## What Gets Installed

- Binary: `${PREFIX}/bin/cool-retro-term`
- Desktop file: `${PREFIX}/share/applications/cool-retro-term.desktop`
- Icons: `${PREFIX}/share/icons/hicolor/{32x32,64x64,128x128,256x256}/apps/cool-retro-term.png`
- QML plugin: Uses Qt's standard `$$[QT_INSTALL_QML]` path (not affected by PREFIX)
