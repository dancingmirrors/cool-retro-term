# PREFIX Installation Support

This project now supports customizable installation paths via the PREFIX variable.

## Quick Start

The recommended way to specify a custom PREFIX:

```bash
qmake
make
bash fix-makefiles.sh  # Patch Makefiles to support PREFIX
sudo make PREFIX=/usr/local install
```

## Details

- **Default PREFIX**: `/usr`  
  Files install to `/usr/bin`, `/usr/share/applications`, etc.

- **Custom PREFIX**: Set to any path like `/usr/local`, `/opt/cool-retro-term`, etc.

## Why fix-makefiles.sh?

qmake generates Makefiles at configuration time with hardcoded paths. The `fix-makefiles.sh` script patches the generated Makefiles to include `.prefix_default.mk` files that define a default PREFIX value while allowing it to be overridden at make-time.

**Note**: You can also set PREFIX when running qmake (`PREFIX=/usr/local qmake`), but this only affects some files. For complete PREFIX support across all installed files, use the fix-makefiles.sh script method.

## Examples

Install to `/usr/local`:
```bash
qmake
make
bash fix-makefiles.sh
sudo make PREFIX=/usr/local install
```

Install to `/opt`:
```bash
qmake
make
bash fix-makefiles.sh
sudo make PREFIX=/opt install
```

Install to a staging directory (for packaging):
```bash
qmake
make  
bash fix-makefiles.sh
make install INSTALL_ROOT=/tmp/staging PREFIX=/usr
```

## What Gets Installed

- Binary: `${PREFIX}/bin/cool-retro-term`
- Desktop file: `${PREFIX}/share/applications/cool-retro-term.desktop`
- Icons: `${PREFIX}/share/icons/hicolor/{32x32,64x64,128x128,256x256}/apps/cool-retro-term.png`
- QML plugin: Uses Qt's standard `$$[QT_INSTALL_QML]` path (not affected by PREFIX)

## For Package Maintainers

If you're packaging cool-retro-term for a distribution:

```bash
qmake
make
bash fix-makefiles.sh
make install INSTALL_ROOT="${pkgdir}" PREFIX=/usr
```

This will install to `${pkgdir}/usr/bin/cool-retro-term` etc., which is the standard for most package systems.
